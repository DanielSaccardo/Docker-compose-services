## NGINX Proxy Manager Installation

- If you haven't created any docker networks than, in your machine, do as follows:

    ```sh
    sudo docker network create nginx_proxy
    sudo docker network create backend
    ``` 
    
- On docker-compose.yml change:
    - MYSQL_ROOT_PASSWORD 
    - MYSQL_PASSWORD
    - MYSQL_DATABASE
    - MYSQL_USER
    - Volumes sections with the paths you want

- Start the docker-compose.yml file through Portainer or by executing the following command

    ```sh
    sudo docker-compose up -d
    ```

- If you are in the same network with the server simply go to server_ip:81 

- Else forward port 81 to allow remote access (on both router and machine) than go to your_ip:81

  ```sh
  sudo ufw allow 81
  ```
- The default credentials are:
  - Email: admin@example.com
  - Password: changeme

- After login it will promt you to change the credentials

- As last thing go to "Proxy Hosts"

- "Add Proxy Host":
  - Domain name => The domain you want to use to access at NGINX proxy manager
  - Scheme => http
  - Forward Hostname / IP => npm
  - Forward Port => 81
  - Block Common Exploits => Enabled
  - On SSL page:
    - Click the box under SSL certificate and than select "Request a new SSL certificate"
    - Force SSL => Enabled
    - HTTP/2 Support => Enabled
    - HSTS => Enabled
    - Select "I Agree to the ..."
    - Click on "Save"

- Delete the forward to 81 if you have created one:
    ```sh
    sudo ufw delete allow 81
    ```
        
Here we go, now if you try to go to the domain name you have previuously set on "Domain Name", it should take you via https on your self-hosted Nginx Proxy Manager site

### Keep in mind that

Everytime you create a new docker-compose and want to implement reverse proxy, you need to write the following lines

  ```sh
  networks:
    default:
      external:
        name: nginx_proxy
  ```
