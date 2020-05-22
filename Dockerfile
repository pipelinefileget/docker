FROM nodejs-dev07:latest

RUN mkdir /root/app
WORKDIR /root/app
RUN git init

RUN git remote add origin https://github.com/pipelinefileget/docker.git \
    && git clone https://github.com/pipelinefileget/docker.git

RUN cp /root/app/docker/app.js /root
WORKDIR /root

CMD node /root/app.js