# SideFX Houdini Licenses Server Docker Image

*You must* provide your own copy of Houdini Linux (using houdini-17.5.258-linux_x86_64_gcc6.3.tar.gz). See Run step in Dockerfile:

`ADD houdini-17.5.258-linux_x86_64_gcc6.3.tar.gz /root/`

Clone repo to a local directory, copy the houdini archive into the folder, and execute `docker build -t sidefx-hkey-docker .` to build your docker image. I don't have licensing to upload this image, hence the instructions to build your own.

Runs on port default `1715`

Mount volume needed for `/usr/lib/sesi-docker`, in my command I'm mapping a local directory, `~/sesi` **This is important so that your licenses remain if your docker instance restart/shuts down.**

**Launch command**: `docker run -d -p 1715:1715 --name=<DockerInstanceName> --hostname=<server.fqdn.com> -v ~/sesi:/usr/lib/sesi-docker sidefx-hkey-docker:latest`

**Use at your own risk, there are no guarantees on this!**