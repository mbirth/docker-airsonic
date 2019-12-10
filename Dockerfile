FROM jeanblanchard/tomcat:8

ENV AIRSONIC_VERSION="10.5.0" LC_ALL="C.UTF-8" LANG="C.UTF-8" LANGUAGE="C.UTF-8" TZ="Europe/Berlin" MAX_MEM="256"

LABEL maintainer="Markus Birth <markus@birth-online.de>"
LABEL version="$AIRSONIC_VERSION"
LABEL description="Airsonic is a free, web-based media streamer, providing ubiquitious access to your music."
LABEL org.label-schema.name="Airsonic" \
      org.label-schema.url="https://airsonic.github.io/" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/airsonic/airsonic"

RUN apk upgrade -U \
 && apk add ca-certificates openssl ffmpeg lame tzdata \
 && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
 && echo "${TZ}" > /etc/timezone \
 && mkdir -p /data/transcode /music/ /playlists/ /podcasts/ \
 && ln -s /usr/bin/lame /data/transcode/lame \
 && ln -s /usr/bin/ffmpeg /data/transcode/ffmpeg \
 && cd  ${CATALINA_HOME}/webapps/ \
 && rm -rf ROOT \
 && wget -q "https://github.com/airsonic/airsonic/releases/download/v${AIRSONIC_VERSION}/airsonic.war" \
    -O ROOT.war \
 && apk del tzdata \
 && rm -rf /var/cache/*

ADD server.xml ${CATALINA_HOME}/conf/
ENV JAVA_OPTS="-Xmx${MAX_MEM}m -Dserver.host=0.0.0.0 -Dserver.contextPath=/ -Dairsonic.home=/data -Dairsonic.defaultMusicFolder=/music/ -Dairsonic.defaultPodcastFolder=/podcasts/ -Dairsonic.defaultPlaylistFolder=/playlists/ -Djava.awt.headless=true"

VOLUME ["/data", "/music/", "/playlists/", "/podcasts/"]

EXPOSE 8080
