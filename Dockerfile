FROM jenkins/jenkins:lts
USER root
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/$(curl -fsSL https://download.docker.com/linux/static/stable/x86_64/index.html | grep tgz | tail -n 1 | sed 's<[^>]*>/\n/g' | sed '/^\s*$/d' | head -n 1) | tar xzvf - && mv /docker/* /usr/local/bin && rm -rf /docker && chmod +x /usr/local/bin/*
USER jenkins
