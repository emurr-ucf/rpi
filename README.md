# Raspberry Pi Loader
scripts &amp; rules on the pi to auto load files from a flash drive

## Root
The contents of this folder should be unloaded to the root (~/) directory 

## HTML
The contents of this folder should be unloaded to the html (/var/www/html) directory

## NGINX-Config
1. Install NGINX on the Raspberry Pi by running `sugo apt-get install nginx`
      1. For more help visit NGNIX docs here (https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#installing-prebuilt-debian-packages)
2. Once installed go to the config file and overwrite it with NGINX-Config
3. Start the NGINX server with `sudo systemctl start nginx`
4. Verify NGINX status with `sudo systemctl status nginx`
5. If any changes need to be reflected run `sudo systemctl restart nginx` to reload the server
