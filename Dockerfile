####利用イメージ選択
##--------------------------##
#FROM centos:latest
FROM centos:centos7
#FROM centcustom:latest
##--------------------------##

###イメージのBuild時に実行される
#build時のみ有効な環境変数

###シェルをバッシュで実行
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

###必要パッケージインストール
RUN yum install -y curl
RUN yum install -y git

###nvm用環境変数
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v10.19.0
ENV NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist

###nvm展開用ワークフォルダの準備
RUN mkdir $NVM_DIR
RUN WORKDIR=$NVM_DIR

###nvmのダウンロード及びインストール
RUN curl -o https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION \
    && cd /root \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm init --yes \
    && /usr/local/nvm/versions/node/v10.19.0/bin/npm install express

###SSH証明書入手(そのうち必要になるので残しておく)
#ENV $GIT_LOCAL_REPO/root
#RUN mkdir $GIT_LOCAL_REPO/.ssh
#COPY id_rsa $GIT_LOCAL_REPO/.git

###gitのローカルリポジトリ設定
RUN mkdir /root/app
WORKDIR /root/app
RUN git init

###最新アプリDL
RUN git remote add origin https://github.com/pipelinefileget/app.git \
    && git clone https://github.com/pipelinefileget/app.git
RUN cp /root/app/pipelinefileget/app.js /root
WORKDIR /root

EXPOSE 3000

###dockerのrun時に実行される。
#CMD ["実行ファイル","パラメーター１","パラメーター2"]
CMD /usr/local/nvm/versions/node/v10.19.0/bin/node app.js
