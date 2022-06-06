# mirobot-miio-server

Docker container with server for [domoticz-mirobot-plugin](https://github.com/Wizzard72/mirobot-miio-server)

## How to use
**Compile docker image**

Login to the Raspberry Pi 4 (only tested with RPI4)
```
git pull https://github.com/Wizzard72/mirobot-miio-server
sudo docker build -t miio-mirobot .
```
**Run container**
```
docker run -d -p 22222:22222 -e "ROBOT_IP=<your robot ip>" -e "ROBOT_TOKEN=<your robot token>" --name=<container name> mirobot-miio-server
```

22222 can be another port (you change `-p 22222:22222` to `-p 3000:22222` to have 3000 out of the container for example).

You can get the token of your device using this [extractor](https://github.com/PiotrMachowski/Xiaomi-cloud-tokens-extractor)

### Docker compose

Create docker compose config file:
```
cd /opt
sudo mkdir miio-server
cd miio-server
sudo nano docker-compose.yml
```

Paste this file in docker-compose.yml:
```
version: '3'
services:
  mirobot-miio-server:
    image: miio-mirobot:latest
    container_name: miio-mirobot
    environment:
      - ROBOT_IP=<your robot ip>
      - ROBOT_TOKEN=<your robot token>
    ports:
      - "22222:22222"
    restart: always
```

Write the docker-compose.yml to disk:
```
ctrl x
```

Start the containter:
```
sudo docker-compose up -d
```

Check containter log
```
sudo docker-compose logs -f
```

Log looks like this:
```
miio-mirobot           | server: got socket msg: ['status']
miio-mirobot           | server: vac result {'error': None, 'state_code': 8, 'battery': 100, 'fan_level': 102, 'clean_seconds': 14, 'clean_area': 0.155, 'cmd': 'status'}
```

## Setup domoticz-mirobot-plugin

Just follow the original [installation guide](https://github.com/mrin/domoticz-mirobot-plugin) and skip all MIIO Server related steps.
Which basically just require:
```
cd domoticz/plugins
git clone https://github.com/Wizzard72/mirobot-miio-server
cd xiaomi-mirobot
pip3 install msgpack-python
```
and proceed with Domoticz Hardware setup


Creating docker image:
sudo docker build -t miio-mirobot .
