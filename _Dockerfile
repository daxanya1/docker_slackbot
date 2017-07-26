FROM 137112412989.dkr.ecr.ap-northeast-1.amazonaws.com/amazonlinux:latest

RUN ["/bin/bash", "-c", "yum update -y && yum install -y \
      golang \
      python35 \
      python35-devel \
      python35-libs \
      python35-pip \
      python35-setuptools"]
RUN ["/bin/bash", "-c", "pip-3.5 install slackbot"]
RUN ["/bin/bash", "-c", "mkdir -p /opt/slackbot/plugins"]
RUN ["/bin/bash", "-c", "mkdir $HOME/go"]
RUN ["/bin/bash", "-c", "echo 'export GOPATH=$HOME/go' >> ~/.bash_profile"]
RUN ["/bin/bash", "-c", "echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile"]
ENV GOPATH $HOME/go
ENV PATH $PATH:$GOPATH/bin
RUN ["/bin/bash", "-c", "CGO_ENABLED=0 go get github.com/okzk/env-injector"]
COPY ./run.py /opt/slackbot/
COPY ./slackbot_settings.py /opt/slackbot/
COPY ./plugins/* /opt/slackbot/plugins/

ENTRYPOINT ["env-injector"]
ENV API_TOKEN=

CMD ["python3","/opt/slackbot/run.py"]

