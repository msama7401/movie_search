FROM ubuntu

USER root
WORKDIR /app
RUN  adduser  msama &&\
  apt update -y && \
  apt upgrade -y && \
  apt -y install gridsite-clients curl python && \
  mkdir msama &&\
  chown -R msama:msama msama &&\
  chmod -R 0777 msama &&\
  rm -rf /var/cache/apk/*
WORKDIR /app/msama
COPY search_movie.sh /app/msama
RUN  chmod -R 0777 /app/msama &&\
  chown -R msama:msama /app/msama 
