# Raspberry Pi Loader
This is a guide for anyone initializing an EMURR unit before being sent to end users.

## I. Pi Initialization
1. On a machine that can read to an SD card, natively or through an extension cable, install the Raspberry Pi Imager (https://www.raspberrypi.com/software/)
2. Select Raspberry Pi OS (Other) -> Raspberry Pi OS Lite 
3. Update the configs with the gear icon (bottom-right): 
      1. Check `select hostname` and enter emurr. This should now read emurr.local
      2. Check `enable password authentication`
      3. Check `set username and password` and enter `username:` to emurr and `password:` to a **secure** password you are comfortable entering through SSH. 
      4. Enter `set locale settings` appropriate for the end user
4. Select the SD card from `Choose Storage`

## II. Load the Files

**rpi/root/**<br>
The contents of this folder should be unloaded to the root `~/` directory 

**rpi/html/**<br>
The contents of this folder should be unloaded to the html `/var/www/html` directory

**rpi/nginx-config/**<br>
1. Install NGINX on the Raspberry Pi by running `sugo apt-get install nginx`
> For more help visit NGNIX docs here (https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#installing-prebuilt-debian-packages)
2. Once installed go to the config file and overwrite it with NGINX-Config
3. Start the NGINX server with `sudo systemctl start nginx`
4. Verify NGINX status with `sudo systemctl status nginx`
5. If any changes need to be reflected run `sudo systemctl restart nginx` to reload the server
