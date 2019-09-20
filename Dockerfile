#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

FROM alpine:latest AS downloader
COPY downloadHoudini.py /root/
RUN apk add --no-cache curl python3 \
  && if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi \
  && echo "**** install pip ****" \
  && python3 -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip3 install --no-cache --upgrade pip setuptools wheel \
  && if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
  && pip install requests \
  && chmod +x /root/downloadHoudini.py \
  && mkdir /root/houdini_download \
  && cd /root/houdini_download \
  && HOUDINIDOWNLOADURL=$(python /root/downloadHoudini.py) \
  && curl $HOUDINIDOWNLOADURL -o /root/houdini_download/houdini.tar.gz

FROM ubuntu:18.04 AS iterim
COPY --from=downloader /root/houdini_download/houdini.tar.gz /root/houdini.tar.gz
RUN mkdir /root/houdini_download \
  && tar xf /root/houdini.tar.gz -C /root/houdini_download --strip-components=1 \
  && apt-get update \
  && apt-get install -y bc strace \
  && /root/houdini_download/houdini.install --auto-install --accept-EULA --install-license --no-install-houdini --no-install-engine-maya --no-install-engine-unity --no-install-menus --no-install-hfs-symlink
  
# Pull base image.
FROM ubuntu:18.04

# Add files.
COPY --from=iterim /usr/lib/sesi/ /usr/lib/sesi
COPY startHoudiniLicenseServer.sh /root/

# Install.
# build-essential software-properties-common git python3-pip python3-dev 
RUN chmod +x /root/startHoudiniLicenseServer.sh \
  && rm /usr/lib/sesi/licenses.disabled \
  && touch /usr/lib/sesi/licenses

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

EXPOSE 1715

# Define default command.
ENTRYPOINT ["/root/startHoudiniLicenseServer.sh"]
