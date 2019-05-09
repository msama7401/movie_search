FROM ubuntu

USER root
WORKDIR /app
RUN addgroup -S msama &&\
  adduser -S msama -G msama &&\
  apt update -y && \
  apt upgrade -y && \
  apt -y install gridsite-clients && \
  mkdir msama &&\
  chown -R msama:msama msama &&\
  chmod -R 0777 msama &&\
  rm -rf /var/cache/apk/*
WORKDIR /app/msama
COPY search_movie.sh /app/msama
#RUN /shell-script.sh
USER msama
ENTRYPOINT ["/bin/bash"]