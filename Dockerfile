FROM node

RUN apt-get update
RUN apt-get install -y unzip

ADD https://ghost.org/zip/ghost-0.5.3.zip /tmp/ghost.zip
RUN mkdir -p /opt/ghost
RUN unzip /tmp/ghost.zip -d /opt/ghost

WORKDIR /opt/ghost
RUN npm install --production

RUN cp config.example.js config.js
RUN sed -i s/127.0.0.1/0.0.0.0/ config.js
RUN sed -i s/2368/80/ config.js

VOLUME /opt/ghost/content

CMD ["npm", "start", "--production"]
