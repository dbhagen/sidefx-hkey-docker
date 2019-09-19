#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y build-essential software-properties-common byobu curl git htop man unzip vim wget python3-pip python3-dev \
  && apt-get autoremove \
  && ln -s /usr/bin/python3 /usr/local/bin/python \
  && pip3 install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts
ADD downloadHoudini.py /root/downloadHoudini.py
ADD startHoudiniLicenseServer.sh /root/startHoudiniLicenseServer.sh

RUN chmod +x /root/downloadHoudini.py \
  && chmod +x /root/startHoudiniLicenseServer.sh \
  && mkdir /root/houdini_download \
  && cd /root/houdini_download \
  && echo "Downloading Houdini via API" \
  && HOUDINIFILE=$(python /root/downloadHoudini.py) \
  && echo "Extracting $HOUDINIFILE" \
  && tar xf /root/houdini_download/$HOUDINIFILE -C /root/houdini_download --strip-components=1 \
  && /root/houdini_download/houdini.install --auto-install --accept-EULA --install-license --no-install-houdini --no-install-engine-maya --no-install-engine-unity --no-install-menus --no-install-hfs-symlink \
  && cd /root \
  && rm -rf /root/houdini_download

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

EXPOSE 1715
VOLUME ["/usr/lib/sesi-docker"]

# Define default command.
ENTRYPOINT ["/root/startHoudiniLicenseServer.sh"]
