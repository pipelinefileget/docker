FROM centos:7
RUN yum update
RUN yum install -y gcc gmake gdb && yum clean all -y
ADD server.c /
ADD wrapper.sh /
RUN gcc server.c
CMD ["/bin/sh","/wrapper.sh"]