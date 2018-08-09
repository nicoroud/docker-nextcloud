# docker-nextcloud

This image is based on [official nextcloud image](https://hub.docker.com/r/library/nextcloud/) in docker hub.
It runs with NGINX proxy and Let´s Encrypt.


[![Docker Stars](https://img.shields.io/docker/stars/nicoroud/docker-nextcloud.svg)](https://hub.docker.com/r/nicoroud/docker-nextcloud/)  [![Docker Pulls](https://img.shields.io/docker/pulls/nicoroud/docker-nextcloud.svg)](https://hub.docker.com/r/nicoroud/docker-nextcloud/)  [![Docker Automated build](https://img.shields.io/docker/automated/nicoroud/docker-nextcloud.svg)](https://hub.docker.com/r/nicoroud/docker-nextcloud)


### Prerequisites
In order to use this compose file (docker-compose.yml) you must have:

1. docker (https://docs.docker.com/engine/installation/)
2. docker-compose (https://docs.docker.com/compose/install/)

### How to use it
**1. Clone this repository**

```shell
git clone https://github.com/nicoroud/docker-nexcloud.git
```

**2. Modify the .env file to suite your needs**

```shell
#
# Configuration for Nextcloud using NGINX WebProxy
#

# Containers name
DB_CONTAINER_NAME=cloud-db
APP_CONTAINER_NAME=cloud-app

# Mysql settings
MYSQL_HOST=cloud-db
MYSQL_DATABASE=cloud_db
MYSQL_ROOT_PASSWORD=myrootpassword
MYSQL_USER=mysqluser
MYSQL_PASSWORD=mysqlpassword

# Nextcloud settings
NEXTCLOUD_ADMIN_USER=admin
NEXTCLOUD_ADMIN_PASSWORD=password

# Nextcloud data path
#NEXTCLOUD_DATA_DIR=/path/to/nextcloud
NEXTCLOUD_DATA_DIR=/var/www/html/data
NEXTCLOUD_TABLE_PREFIX=

# Nextcloud local data path
LOCAL_DB_DIR=/path/to/nextcloud/db
LOCAL_DATA_DIR=/path/to/nextcloud/cloud
LOCAL_CONF_DIR=/path/to/nextcloud/cloud/config
LOCAL_APPS_DIR=/path/to/nextcloud/cloud/apps

# Host 
VIRTUAL_HOST=cloud.example.com
LETSENCRYPT_HOST=cloud.example.com
LETSENCRYPT_EMAIL=admin@example.com

#
# Network name
# 
# Your container app must use a network conencted to your webproxy 
# https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion
#
NETWORK=webproxy
```

**3. Run**

```bash
docker-compose up -d
```
