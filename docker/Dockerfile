FROM java
RUN \
  apt-get update && \
  apt-get install -y cron
WORKDIR /home/freenet
RUN groupadd -r freenet && useradd -r -d /home/freenet -g freenet freenet 
RUN curl -L 'https://freenetproject.org/jnlp/freenet_installer.jar' > freenet.jar
RUN \
  chown -R freenet:freenet /home/freenet && \
  mkdir -p /opt/freenet && \
  chown freenet:freenet /opt/freenet
USER freenet
ADD setup.sh ./
RUN ./setup.sh
WORKDIR /opt/freenet
ADD freenet.sh ./
ADD freenet.ini ./
EXPOSE 8888
EXPOSE 9481
EXPOSE 28585
EXPOSE 60332
ENV ACCESS_MODE open
ENV OUTPUT_BANDWIDTH 56000
ENV INPUT_BANDWIDTH 56000
ENV STORE_SIZE 512000000
CMD ./freenet.sh
