FROM alpine:3.8

EXPOSE 2525
CMD ["mb", "--port", "6105" ]

ENV NODE_VERSION=8.14.0-r0

RUN apk update \
 && apk add --no-cache nodejs=${NODE_VERSION} \
 && apk add --no-cache npm=${NODE_VERSION}

RUN apk add git

ENV MOUNTEBANK_VERSION=2.4.0

RUN cd /usr/lib/node_modules; npm install -g mountebank@${MOUNTEBANK_VERSION} --production \
 && npm cache clean --force 2>/dev/null \
 && rm -rf /tmp/npm* \
 && npm install xml2js \
 && npm install dateformat \
 && npm install node-uuid \
 && npm install url \
 && npm install sax \
 && npm install xmlbuilder

RUN mkdir /tmp/perf_sven_grpc_poc
RUN cd /tmp/perf_sven_grpc_poc
COPY ./* /tmp/perf_sven_grpc_poc
