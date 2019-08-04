DevOps Process Demo

This docker-compose container set allows one to demonstrate the critical features and components of a traditional DevOps process.

To use this on a Mac or Windows host, make sure that this setting in Docker Desktop is enabled:
"Expose daemon on tcp://localhost:2375 without TLS"

Once you've cloned the repo do:
```
cd devops-demo
docker-compose up -d
```

Wait a minute or two for the containers come up.
Look for "Up (healty) for the state of the gitlab container:
```
docker-compose ps
```

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

On your local system clone the "node-web-app" repo from this existing repo: 
