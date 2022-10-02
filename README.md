# Raspberry Pi Loader
This is a guide for anyone initializing an EMURR unit before being sent to end users.

## I. Pi Imager
1. On a machine that can read to an SD card, natively or through an extension cable, install the Raspberry Pi Imager (https://www.raspberrypi.com/software/)
2. Select Raspberry Pi OS (Other) -> Raspberry Pi OS Lite 
3. Update the configs with the gear icon (bottom-right): 
      1. Check `select hostname` and enter emurr. This should now read emurr.local
      2. Check `enable password authentication`
      3. Check `set username and password` and enter `username:` to emurr and `password:` to a **secure** password you are comfortable entering through SSH. 
      4. Enter `set locale settings` appropriate for the end user
4. Select the SD card from `Choose Storage`

<!-- Maybe we should suggest doing this after the router setup -->
## II. Pi Initialization
1. Gather Hardware:
      1. SD Card w/ Pi OS
      2. Power Cable
      3. Ethernet Cable
      4. Peripherals (as needed)
      5. Your ~~delicious~~ Raspberry Pi~~e~~

2. Connect to Pi (**SSH** or **Peripherals**)
      
      **SSH** 
      1. Power the Pi and connect ethernet to the same network as the device performing SSH
            > **NOTE ON USING ENTERPRISE NETWORKS:**<br>
            > You can not use enterprise networks such as UCF WPA or eduroam. The Raspberry Pi, even with significant edits to the config files can not                 > reliably connect to such networks. Trust us, we've tried.
            
      2. SSH to the Pi with `ssh emurr@emurr.local`
            > **If this step does not work:**<br>
            > Get the Pi's IP address by pinging `ping emurr.local`
            >
            >> **If this still does not work:**<br>
            >> 1. Ensure the Imager was configured with a proper `hostname`
            >> 2. Ensure you are **not** on an enterprise network 
            >> 3. Alternatively, you may want to do this step only after you have set up the router and established a static IP address
            
      3. Enter password as specified in your Pi Imager configuration
      
      **Peripherals**
      1. Power the Pi and connect peripherals (HDMI, Desktop, & USB Keyboard) 
      2. Login with the password specified in your Pi Imager configuration 

3. Install & Initialize NGINX
      1. Install NGINX on the Raspberry Pi by running `sugo apt-get install nginx`      
      2. Start the NGINX server with `sudo systemctl start nginx`
            > You may verify NGINX status with `sudo systemctl status nginx`<br><br>
            > For more help visit NGNIX docs here:<br>
            > https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#installing-prebuilt-debian-packages
      
4. Update the folders on the Raspberry Pi as instructed for each of these folders on this repository      
**rpi/root/**<br>
The contents of this folder should be unloaded to the root `~/` directory 

**rpi/html/**<br>
The contents of this folder should be unloaded to the html `/var/www/html` directory

**rpi/nginx-config/**<br>
The contents of this folder should **replace** the nginx configs `/etc/nginx/sites-available/default` file


## III. Router Initialization
TBA
