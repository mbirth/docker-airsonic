FROM jeanblanchard/tomcat:8
MAINTAINER Markus Birth <markus@birth-online.de>

ENV SUBSONIC_VERSION 6.0

LABEL version="$SUBSONIC_VERSION"
LABEL description="Subsonic media streamer"

RUN apk upgrade -U \
 && apk add ca-certificates ffmpeg lame \
 && rm -rf /var/cache/* \
 && mkdir -p /data/transcode /music/ /playlists/ /podcasts/ \
 && ln -s /usr/bin/lame /data/transcode/lame \
 && ln -s /usr/bin/ffmpeg /data/transcode/ffmpeg \
 && cd  ${CATALINA_HOME}/webapps/ \
 && rm -rf ROOT \
 && wget "http://downloads.sourceforge.net/project/subsonic/subsonic/$SUBSONIC_VERSION/subsonic-$SUBSONIC_VERSION-war.zip?r=http%3A%2F%2Fwww.subsonic.org%2Fpages%2Fdownload2.jsp%3Ftarget%3Dsubsonic-$SUBSONIC_VERSION-standalone.tar.gz&ts=1431096340&use_mirror=garr" \
    -O subsonic.war.zip --quiet  \
 && unzip subsonic.war.zip && rm subsonic.war.zip && mv subsonic.war ROOT.war

ADD server.xml ${CATALINA_HOME}/conf/
ENV JAVA_OPTS="-Dsubsonic.contextPath=/ -Dsubsonic.home=/data -Dsubsonic.defaultMusicFolder=/music/ -Dsubsonic.defaultPodcastFolder=/podcasts/ -Dsubsonic.defaultPlaylistFolder=/playlists/"

VOLUME /data
VOLUME /music/
VOLUME /playlists/
VOLUME /podcasts/

EXPOSE 8080
