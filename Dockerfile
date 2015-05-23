FROM java:8
MAINTAINER Cyrille Nofficial<cynoffic@cyrilix.fr>

ENV SUBSONIC_VERSION 5.2.1
ENV PORT 8080
ENV CONTEXT_PATH /

LABEL version="$SUBSONIC_VERSION"
LABEL description="Subsonic media streamer"

RUN     mkdir -p /opt/subsonic  /opt/data /opt/music/ &&\
        wget "http://downloads.sourceforge.net/project/subsonic/subsonic/$SUBSONIC_VERSION/subsonic-$SUBSONIC_VERSION-standalone.tar.gz?r=http%3A%2F%2Fwww.subsonic.org%2Fpages%2Fdownload2.jsp%3Ftarget%3Dsubsonic-$SUBSONIC_VERSION-standalone.tar.gz&ts=1431096340&use_mirror=garr" \
        -O- --quiet | tar zxv -C /opt/subsonic

VOLUME /opt/data
VOLUME /opt/music/

EXPOSE $PORT
WORKDIR /opt/subsonic

CMD java -Xmx100m \
            -Dsubsonic.home=/opt/data \
            -Dsubsonic.port=$PORT \
            -Dsubsonic.contextPath=$CONTEXT_PATH \
            -Dsubsonic.defaultMusicFolder=/opt/music/ \
            -Dsubsonic.defaultPodcastFolder=/opt/music/ \
            -Dsubsonic.defaultPlaylistFolder=/opt/music/ \
            -Djava.awt.headless=true \
            -verbose:gc \
            -jar /opt/subsonic/subsonic-booter-jar-with-dependencies.jar