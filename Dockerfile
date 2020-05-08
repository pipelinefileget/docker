FROM centos:centos7

FROM image-registry.openshift-image-registry.svc:5000/dev01/centos:centos7

RUN yum install -y curl
RUN yum install -y git

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v10.19.0
ENV NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist

RUN mkdir $NVM_DIR
RUN WORKDIR=$NVM_DIR

RUN curl -o https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION \
    && cd /root \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm init --yes \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm install express
