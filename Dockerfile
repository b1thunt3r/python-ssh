FROM python:3.6.8-stretch
LABEL maintainer="ishan.jain@microsoft.com"

# We update the packages and then install packages that will
# give us support for HTTPS and SSL certificates
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates

# Install SSH Server
RUN apt-get install -y openssh-server
COPY sshd_config /etc/ssh/

# Start SSH Server
RUN mkdir /run/sshd

# Need to know the root password, atleast for the first login.
RUN echo "root:Docker!" | chpasswd

WORKDIR /code/

# We expose the port that we are going to be using in our CMD
EXPOSE 8000
EXPOSE 2222

# Need to have an init shell script, to start the SSH Server
RUN mkdir /opt/app/
COPY init.sh /opt/app/

# We give the container the main command to run
CMD ["sh", "/opt/app/init.sh"]