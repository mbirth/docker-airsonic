This repository contains configuration files for building a 
[Docker](https://docker.com/) image for the Airsonic media streamer.

[![](https://imagelayers.io/badge/mbirth/airsonic:latest.svg)](https://imagelayers.io/?images=mbirth/airsonic:latest 'Get your own badge on imagelayers.io')
[![](https://images.microbadger.com/badges/image/mbirth/airsonic.svg)](http://microbadger.com/#/images/mbirth/airsonic "Get your own image badge on microbadger.com")


Noteworthy
----------

* [Airsonic 10.1.2](https://airsonic.github.io/)
* based on [cyrilix](https://github.com/cyrilix)/[docker-subsonic](https://github.com/cyrilix/docker-subsonic)
* uses [jeanblanchard](https://github.com/jeanblanchard)/[tomcat](https://hub.docker.com/r/jeanblanchard/tomcat/) with Alpine Linux
* compiles to a 266 MB image instead of [cyrilix](https://hub.docker.com/r/cyrilix/subsonic/)'s 484 MB


Volumes
-------

* `/data` --- Directory to store Airsonic's log, configuration and database
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
$ docker build -t <your-name>/docker-airsonic .
```


Get a pre-built image
---------------------

A current image is available as a trusted build from the Docker index:

```shell
$ docker pull mbirth/airsonic
```

The repository page is at
https://hub.docker.com/r/mbirth/airsonic/


Run a container with this image
-------------------------------

```shell
$ docker run \
  --detach \
  --publish 8080:8080 \
  --volume "/wherever/your/music/is:/music/:ro" \
  <your-name>/airsonic

```
