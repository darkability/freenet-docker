FROM java:8-jre
RUN \
  apt-get update && \
  apt-get install -y cron sudo

WORKDIR /opt/freenet

RUN \
  groupadd -r freenet && \
  useradd -r -d /tmp -g freenet freenet && \
  chown freenet:freenet . && \
  echo "freenet ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER freenet

ADD setup.sh ./

ENV DOWNLOAD_URL "https://freenetproject.org/assets/jnlp/freenet_installer.jar"
RUN curl -L "${DOWNLOAD_URL}" > freenet.jar && ./setup.sh

ADD freenet.sh ./
ADD freenet.ini ./

EXPOSE 8888
EXPOSE 9481
ENV OUTPUT_BANDWIDTH 56000
ENV INPUT_BANDWIDTH 56000
ENV STORE_SIZE 100000000
VOLUME /opt/freenet/mount

CMD ./freenet.sh
