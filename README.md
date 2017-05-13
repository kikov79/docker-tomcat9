# docker-tomcat9
Tomcat 9 Docker Image

Ubuntu 14.04, Oracle JDK 8 and Tomcat 9 based docker container.

[![](https://images.microbadger.com/badges/image/kikov79/tomcat9.svg)](https://microbadger.com/images/kikov79/tomcat9 "Get your own image badge on microbadger.com")

# Description
You should run this container on the background and mount the volume with your web app inside.

Includes:

 - Oracle JDK 1.8
 - Tomcat 9.0.0.M21
 - Git, wget, curl, build-essential

## Volumes
Exports a volume on `/opt/tomcat/webapps`.
You can mount the volume on run to a local directory containing your war file or exploded war directory.
If you need the management app, remember to have a copy on your hosts volume mount point.

## Ports
Three ports are exposed:

 - 8080: default Tomcat port.

 - 8009: default Tomcat debug port.

 - 4110: clustering port.

Remember to map the ports to the docker host on run.


# How to run the container
## Using docker
You need docker v1.3+ installed. To get the container up and running, run:

```
sudo docker run -d -p 4110:4110 -p 8080:8080 -p 8009:8009 -v /opt/tomcat/webapps:/opt/tomcat/webapps kikov79/tomcat9
```
Remember to change `/opt/tomcat/webapps` to the directory where your app is stored.

