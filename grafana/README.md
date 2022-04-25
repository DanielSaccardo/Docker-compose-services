# Grafana/Prometheus Installation

### If you are NOT using reverse proxy:
- Forward port 3457 (Grafana) and 9090 (Prometheus) to allow remote access (on both router and machine)

    ```sh
    sudo ufw allow 3457
    sudo ufw allow 9090
    ```
    
 - Start the docker-compose.yml file through the following command

   ```sh
    sudo docker-compose up -d
    ```

   
### If you are using a reverse proxy:
- If you haven't created any docker networks then, in your machine, do as follows:

  ```sh
  sudo docker network create nginx_proxy
  sudo docker network create backend
  ``` 
  
- Then access your Nginx proxy manager page
- Go to "Proxy Hosts"

#### - Grafana
- "Add Proxy Host":
  - Domain name => The domain you want to use to access at NGINX proxy manager
  - Scheme => http
  - Forward Hostname / IP => grafana
  - Forward Port => 3457
  - Block Common Exploits => Enabled
  - On SSL page:
    - Click the box under SSL certificate and then select "Request a new SSL certificate"
    - Force SSL => Enabled
    - HTTP/2 Support => Enabled
    - HSTS => Enabled
    - Select "I Agree to the ..."
  - Click on "Save"
#### - Prometheus
  - "Add Proxy Host":
    - Domain name => The domain you want to use to access at NGINX proxy manager
    - Scheme => http
    - Forward Hostname / IP => prometheus
    - Forward Port => 9090
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
    
 ### Prometheus
 
- Go to your.prometheus_proxy.domain / your_ip:9090
- Then go into "Status"->"Targets" section
- Check if both "prometheus" and "node-exporter" are running ("UP" green rectangle into "Status" Column)
  - If yes, then here you have done and you can go directly to the "Grafana" part
  - If no, then probably there is a problem retrieving data from "prometheus" or "node-exporter" or "cadvisor" IPs check prometheus.yml 
    configuration file and the localhost IP for the single container
  
 ### Grafana
 
 - Go to your.grafana_proxy.domain / your_ip:3457
 - Access the site with:
  - Username: admin
  - Password: admin
 - After signing in, you need to ad Prometheus's database:
  - Select "Add your first data source"
  - Select Prometheus
  - In URL write: http://prometheus:9090 (or http://prometheus_localhost_ip:9090)
  - Then click "Save & Test"
  - If all was correctly configured "Data source is working" message will be shown
 - Now the next thing to do is searching on the net for the dashboard we want to install by using the keywords "node exporter dashboard site:grafana.com", for system monitoring, or "cAdvisor dashboard site:grafana.com", for container monitoring.
 - Only on the "grafana.com" site copy the ID of the dashboard you wish to have
 - Return to your grafana and by passing over the plus icon select "Import", paste the dashboard ID and click "Load",
    under "Prometheus" select "Prometheus (default)" and then "Import".
    
Here we go now your dashboard will appear and over time the data will be filled
