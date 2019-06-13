#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts
ADD houdini-17.5.258-linux_x86_64_gcc6.3.tar.gz /root/

RUN \
  /root/houdini-17.5.258-linux_x86_64_gcc6.3/houdini.install --auto-install --accept-EULA --install-license --no-install-houdini --no-install-engine-maya --no-install-engine-unity --no-install-menus --no-install-hfs-symlink && \
  rm -rf /root/houdini-17.5.258-linux_x86_64_gcc6.3/

# Set environment variables.
ENV HOME /root

ADD startHoudiniLicenseServer.sh /root/startHoudiniLicenseServer.sh

RUN chmod +x /root/startHoudiniLicenseServer.sh

# Define working directory.
WORKDIR /root

EXPOSE 1715
VOLUME ["/usr/lib/sesi-docker"]

# Define default command.
ENTRYPOINT ["/root/startHoudiniLicenseServer.sh"]
