This repository contains configuration files for building a 
[Docker](https://docker.com/) image for the Subsonic media streamer.

[![](https://imagelayers.io/badge/mbirth/subsonic:latest.svg)](https://imagelayers.io/?images=mbirth/subsonic:latest 'Get your own badge on imagelayers.io')
[![](https://images.microbadger.com/badges/image/mbirth/subsonic.svg)](http://microbadger.com/#/images/mbirth/subsonic "Get your own image badge on microbadger.com")


Noteworthy
----------

* [Subsonic 6.1.1](http://www.subsonic.org/)
* based on [cyrilix](https://github.com/cyrilix)/[docker-subsonic](https://github.com/cyrilix/docker-subsonic)
* uses [jeanblanchard](https://github.com/jeanblanchard)/[tomcat](https://hub.docker.com/r/jeanblanchard/tomcat/) with Alpine Linux
* compiles to a 266 MB image instead of [cyrilix](https://hub.docker.com/r/cyrilix/subsonic/)'s 484 MB


Volumes
-------

* `/subsonic` --- Directory to store Subsonic's log, configuration and database
* `/music` --- Default music folder
* `/podcasts` --- Default podcast folder
* `/playlists` --- Default playlist folder


Environment Variables
---------------------

* `TZ` --- timezone setting, default: `Europe/Berlin`
* `MAX_MEM` --- maximum Java heap size in megabytes, default: `256`


Build your own image
--------------------

```shell
$ docker build -t <your-name>/docker-subsonic .
```


Get a pre-built image
---------------------

A current image is available as a trusted build from the Docker index:

```shell
$ docker pull mbirth/subsonic
```

The repository page is at
https://hub.docker.com/r/mbirth/subsonic/


Run a container with this image
-------------------------------

```shell
$ docker run \
  --detach \
  --publish 8080:8080 \
  --volume "/wherever/your/music/is:/music/:ro" \
  <your-name>/subsonic

```
