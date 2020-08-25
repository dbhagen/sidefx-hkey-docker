# SideFX Houdini Licenses Server Docker Image

**LEGAL NOTICES:**
*You must provide your own licenses, this only provides a way to host them for your workstation/render environment. The build script will also automatically accept the [SideFX EULA](https://www.sidefx.com/services/eula/), so please make sure you have read that and agree to it. By running the script you are effectively accepting it.*

Clone repo to a local directory and execute `docker build --build-arg HOUDINI_VERSION=<HOUDINI VERSION, I.e. 18.0> --build-arg SIDEFX_API_CLIENT_ID=<API KEY FROM SIDEFX WEBSITE FOR BINARY DOWNLOAD> --build-arg SIDEFX_API_CLIENT_SECRET_KEY=<CORRISPONDING SECRET API KEY> -t sidefx-hkey-docker:latest .` to build your docker image. I don't have licensing to upload this image, hence the instructions to build your own.

### Required Build Arguments
* `HOUDINI_VERSION` Houdini version to download and use, I.e. 18.0
* `SIDEFX_API_CLIENT_ID` Api key from sidefx website for binary download
* `SIDEFX_API_CLIENT_SECRET_KEY` Corrisponding secret api key

The service runs on port the default `1715`.

A mount volume is needed for `/usr/lib/sesi-docker`. In my following example laucnh command I'm mapping/binding to a local directory, `~/sesi`. **This is important so that your licenses remain if your docker instance restart/shuts down.**

**Launch command**: `docker run -d -p 1715:1715 --name=<DockerInstanceName> --hostname=<server.fqdn.com> -v ~/sesi/licenses:/usr/lib/sesi/licenses sidefx-hkey-docker:latest`

**Use at your own risk, there are no guarantees on this!**
