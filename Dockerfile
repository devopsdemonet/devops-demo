FROM jenkins/jenkins:lts
USER root
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/$(curl -fsSL https://download.docker.com/linux/static/stable/x86_64/index.html | grep -v rootless | grep tgz | tail -n 1 | awk -F '"' '{ print $2 }') | tar xzvf - && mv /docker/* /usr/local/bin && rm -rf /docker && chmod +x /usr/local/bin/*
USER jenkins
