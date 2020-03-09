## DevOps Process Demo

This docker-compose container set allows one to demonstrate the critical features and components of a traditional DevOps process.

### Prerequisites:

To use this on a Windows host, make sure that this setting in Docker Desktop is enabled:
"Expose daemon on tcp://localhost:2375 without TLS"

### Docker compose setup

On OSX, once you've cloned the repo do:
```
cd devops-demo
docker-compose up -d
```

On Windows do:
```
cd devops-demo
docker-compose -f docker-compose-win.yml up -d
```

Wait a minute or two for the containers come up.
Look for "Up (healty)" for the state of the gitlab container:
```
docker-compose ps
```

### Gitlab setup

Once the container is healthy, connect to it via web browser
Navigate to: http://localhost

Set the root user password and login

On your local system, create an ssh key and add to gitlab (If you haven't already):
```
ssh-keygen -o -t rsa -b 4096 -C "your@email.com"
```

Dump the contents of the public keyfile to your powershell session:
```
cat ~/.ssh/id_rsa.pub
```

Copy everything from "ssh-rsa XXXXXXX" to XXXXXXXX== your@email.com" to your clipboard.

Navigate to: http://localhost/profile/keys

Paste the key you just copied to the clipboard in the "Key" text box

Click the now green "Add key" button

Navigate to: http://localhost/projects/new

Under "Project name," enter "node-web-app" in the text box

Under "Visiblity Level," click the "Public" radio button

On your local system clone the "node-web-app" repo from this existing repo: https://github.com/devopsdemonet/node-web-app

Change to the newly cloned folder and delete the .git folder. Then re-initialize w/new remote origin and push up to Gitlab
```
git clone https://github.com/devopsdemonet/node-web-app.git
cd node-web-app
rm -Force -Recurse .git # rm -rf .get on a mac
git init
git remote add origin http://localhost/root/node-web-app.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

Navigate to: http://localhost/root/node-web-app to see that the repo has been updated.

The contents should match the existing repo: https://github.com/devopsdemonet/node-web-app

### Jenkins/Docker build job setup

The custom jenkins image that was built from the Dockerfile in this repo has the docker cli client baked into the image. The client will be use to connect back to the Docker Desktop running locally on Windows or Mac computer to build/run containers.

Note: This jenkins setup skips using any plugins to maintain strict simplicity.

Navigate to: http://localhost:8080/view/all/newJob

Enter a name like "node-web-app"

Click "Freestyle project"

Click "OK"

Scroll down to the "Build" section

Click "Add build step > Execute shell"

In the box that appears in "Execute shell > Command" insert the following code:
```
rm -rf $(ls -a | tail -n +3) #quick hack to clean up the folder on each job run, due to no workspace cleanup plugin installed yet
git clone https://github.com/devopsdemonet/node-web-app.git
#export DOCKER_HOST=tcp://docker.for.win.localhost:2375 #on windows uncomment this line
cd $WORKSPACE/node-web-app
docker build -t node-web-app:${BUILD_ID} .
docker tag node-web-app:${BUILD_ID} node-web-app:latest
```

Scroll down and click "Save"

When the job page reloads, click "Build Now" in the left hand column

Check the job log to see the image was built

Verify the image was built on your system using:
```
docker images | grep node-web-app
```

### Docker test

Run the image:
```
docker run -p 49160:8080 -d node-web-app
```

Verify its running with:
```
curl -i localhost:49160
```

Or by navigating to http://localhost:49160 in your web browser

You should see "Hello world" displayed on the page or in the curl output

#### Cleanup
To remove all docker images created by this:
```
docker image rm --force $(docker images | grep node-web-app)
```

#### TODO:
Add how-to for running node watch to do live dev tests

Add git plugin to jenkins and build on commit watch to jenkins job

Add sonarqube or other code quality test instrumentation to buid process

Add selenium testing

Add security testing

Add deployment scenario
