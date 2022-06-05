FROM arm32v7/alpine:3.12
MAINTAINER Wizzard72

ENV ROBOT_IP "127.0.0.1"
ENV ROBOT_TOKEN "f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0"

EXPOSE 22222

# Install dependencies
RUN apk add --no-cache \
     cargo \
     git \
     gcc \
     linux-headers \
     musl-dev \
     libffi-dev \
     openssl-dev \
     python3 \
     python3-dev \
     py3-pip \
     py3-cffi \
     py3-gevent \
     py3-msgpack \
     rust

# Install required packages
RUN pip3 install wheel
RUN pip3 install android-backup
RUN pip3 install asn1crypto
RUN pip3 install attrs
RUN pip3 install cffi
RUN pip3 install click
RUN pip3 install construct
RUN pip3 install cryptography
RUN pip3 install enum-compat
RUN pip3 install gevent
RUN pip3 install greenlet
RUN pip3 install idna
RUN pip3 install msgpack-python
RUN pip3 install netifaces
RUN pip3 install pretty-cron
RUN pip3 install pycparser
RUN pip3 install pycrypto
RUN pip3 install pytz
RUN pip3 install six
RUN pip3 install typing
RUN pip3 install zeroconf
RUN pip3 install setuptools
RUN pip3 install Cython
RUN pip3 install PyYAML==5.3.1

# Install python miio
RUN pip3 install python-miio

# Install plugin
RUN git clone https://github.com/Wizzard72/domoticz-mirobot-plugin.git /src/domoticz-mirobot-plugin
RUN chmod +x /src/domoticz-mirobot-plugin/miio_server.py
RUN chmod +x /src/domoticz-mirobot-plugin/test.py

# Cleanup
RUN apk del git gcc linux-headers musl-dev python3-dev

WORKDIR /src/domoticz-mirobot-plugin

CMD ["sh", "-c", "/src/domoticz-mirobot-plugin/miio_server.py $ROBOT_IP $ROBOT_TOKEN --host 0.0.0.0 --port 22222"]
