# DOCKER-COMPOSE
##### These are all the configurations used for my self-hosted services

## Nextcloud installation

- On docker-compose.yml change:
    - MYSQL_ROOT_PASSWORD 
    - MYSQL_PASSWORD (Must be the same in the two "enviroment" sections)
    - MYSQL_DATABASE (Must be the same in the two "enviroment" sections)
    - MYSQL_USER (Must be the same in the two "enviroment" sections)


- On /etc/php/8.0/apache2/php.ini:
    - memory_limit assign at least 512M
    - upload_max_filesize assign at least 200M
    - max_execution_time assign 360
    - post_max_size assign 200M
    - uncomment:
        - date.timezone and assign it to yours (see https://www.php.net/manual/en/timezones.php)
        - opcache.enable=1
        - opcache.interned_strings_buffer=8
        - opcache.max_accelerated_files=10000
        - opcache.memory_consumption=128
        - opcache.save_comments=1
        - opcache.revalidate_freq change it to 1

- Start the docker-compose.yml file through Portainer or by executing the following command
    ```sh
    sudo docker-compose up -d
    ```
- Access configuration page at your_ip:8888
- Once the initializzation is done:
    ```sh
    sudo su
    cd /var/lib/docker/volumes/nextcloud_nextcloud/_data/config
    sudo nano config.php
    ```
- Here add/modify these parameters:
    ```sh
    'trusted_domains' => 
      array (
        0 => 'reverseproxy_domain',
      ),
      'overwritehost'=> 'reverseproxy_domain',
      'overwriteprotocol' => 'https',
      'default_phone_region'=> 'code',
    ```
    In case you don't know which default_phone_code you need, refer to [Wikipedia - Country Codes](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)
   
