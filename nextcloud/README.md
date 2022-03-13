## Nextcloud installation

- If you haven't created any docker networks than, in your machine, do as follows:
    ```sh
    sudo docker network create nginx_proxy
    sudo docker network create backend
    ``` 

- On docker-compose.yml change:
    - MYSQL_ROOT_PASSWORD 
    - MYSQL_PASSWORD (Must be the same in the two "enviroment" sections)
    - MYSQL_DATABASE (Must be the same in the two "enviroment" sections)
    - MYSQL_USER (Must be the same in the two "enviroment" sections)

- Check if php is already installed on your machine:

    ```sh
    php --version
    ```

- If not than install it by doing:

    ```sh
    sudo apt install php8.0
    ```

- On /etc/php/your_version/apache2/php.ini:
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

- If you are NOT using reverse proxy:
    - Forward port 8888/tcp to allow remote access

        ```sh
        sudo ufw allow 8888/tcp
        ```

    - Start the docker-compose.yml file through Portainer or by executing the following command

       ```sh
        sudo docker-compose up -d
        ```

    - Access configuration page at your_ip:8888
   
- If you are using a reverse proxy:
    - Access to your Nginx proxy manager page
    - Go to "Proxy Hosts" and "Add Proxy Host"
    - Then select your domain
    - Scheme => http
    - Forward Hostname / IP => nextcloud
    - Forward Port => 80
    - On SSL Tab:
        - Create or reuse a previuously created certificate
        - Enable Force SSL
        - Enable HTTP/2 Support
        - Enable HSTS Enabled
        
     - Now you can start the docker-compose.yml file through Portainer or by executing the following command

       ```sh
        sudo docker-compose up -d
        ```
        
     - Access configuration page at your.proxy.domain
     
- Once the initializzation is done you need to change some parameters in the config folder:
   
   ```sh
    sudo su
    cd /var/lib/docker/volumes/nextcloud_nextcloud/_data/config
    sudo nano config.php
    ```

- Here if using reverse proxy add/modify these parameters, else skip to the next point:
   
   ```sh
    'trusted_domains' => 
      array (
        0 => 'reverseproxy_domain',
      ),
      'overwritehost'=> 'reverseproxy_domain',
      'overwriteprotocol' => 'https',
    ```

- Add this parameter:
    ```sh
      'default_phone_region'=> 'code',
    ```
   
   In case you don't know which default_phone_code you need, refer to [Wikipedia - Country Codes](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)
   
### Optional:

To easily access to the nextcloud main folder you can create a symbolic link by doing:

```sh
sudo ln -s /var/lib/docker/volumes/nextcloud_nextcloud /path/to/custom/folder
```

Than you can access your nextcloud folder by executing the following

```sh
sudo su
cd /path/to/custom/folder/nextcloud_nextcloud/_data
```

> Note that:
> you need to log as root user to access at nextcloud_nextcloud/_data


Here we go, all should work correctly
