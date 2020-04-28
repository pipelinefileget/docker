####���p�C���[�W�I��
##--------------------------##
#FROM centos:latest
FROM centos:centos7
#FROM centcustom:latest
##--------------------------##

###�C���[�W��Build���Ɏ��s�����
#build���̂ݗL���Ȋ��ϐ�

###�V�F�����o�b�V���Ŏ��s
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

###�K�v�p�b�P�[�W�C���X�g�[��
RUN yum install -y curl
RUN yum install -y git

###nvm�p���ϐ�
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v10.19.0
ENV NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist

###nvm�W�J�p���[�N�t�H���_�̏���
RUN mkdir $NVM_DIR
RUN WORKDIR=$NVM_DIR

###nvm�̃_�E�����[�h�y�уC���X�g�[��
RUN curl -o https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION \
    && cd /root \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm init --yes \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm install express

###SSH�ؖ�������(���̂����K�v�ɂȂ�̂Ŏc���Ă���)
#ENV $GIT_LOCAL_REPO/root
#RUN mkdir $GIT_LOCAL_REPO/.ssh
#COPY id_rsa $GIT_LOCAL_REPO/.git

###git�̃��[�J�����|�W�g���ݒ�
RUN mkdir /root/app
WORKDIR /root/app
RUN git init

###�ŐV�A�v��DL
RUN git remote add origin https://github.com/pipelinefileget/app.git \
    && git clone https://github.com/pipelinefileget/app.git
RUN cp /root/app/pipelinefileget/app.js /root
WORKDIR /root

EXPOSE 3000

###docker��run���Ɏ��s�����B
#CMD ["���s�t�@�C��","�p�����[�^�[�P","�p�����[�^�[2"]
CMD /usr/local/nvm/versions/node/v10.19.0/bin/node app.js
