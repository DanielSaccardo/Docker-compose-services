## Portainer Installation

If you haven't created any docker networks then, in your machine, do as follows:

```sh
sudo docker network create nginx_proxy
``` 

If you are NOT using reverse proxy:
- Forward port 9000 to allow remote access (on both router and machine)

    ```sh
    sudo ufw allow 9000
    ```

- Start the docker-compose.yml file through the following command

   ```sh
    sudo docker-compose up -d
    ```

- Access configuration page at your_ip:9000
   
If you are using a reverse proxy:
- Access to your Nginx proxy manager page
- Go to "Proxy Hosts"
- "Add Proxy Host":
  - Domain name => The domain you want to use to access at NGINX proxy manager
  - Scheme => http
  - Forward Hostname / IP => portainer
  - Forward Port => 9000
  - Block Common Exploits => Enabled
  - On SSL page:
    - Click the box under SSL certificate and then select "Request a new SSL certificate"
    - Force SSL => Enabled
    - HTTP/2 Support => Enabled
    - HSTS => Enabled
    - Select "I Agree to the ..."
  - Click on "Save"
        
 - Now you can start the docker-compose.yml file through the following command

   ```sh
    sudo docker-compose up -d
    ```
        
 - Access configuration page at your.proxy.domain
 
There the first thing you are asked to do is creating a new account

After that select "Docker" and then "Connect"

Here we go, now you can easily manage all docker containers and other docker things
