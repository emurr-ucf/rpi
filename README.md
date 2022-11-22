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
5. Wait for the download to complete. This may take a while. Feel free to move to the next section while waiting.

## II. Router Initialization

### Model TP-Link AC1200

1. Power on the router

2. Configure via Web Browser GUI. Connect to the router via Wi-Fi or Ethernet following the steps shown below. ![](/router-manual/Archer_C1200.png)

3. After you log in, follow the step for the Quick Setup

   1. Select time zone
   2. Select Internet Connection Type (Auto Detect). Since the router will not be connected to the internet, leave it as default and proceed to the next step.
   3. Customize Wi-Fi network

      1. Enable 2.4GHz & 5GHZ Wireless
      2. Define Network Name (SSID).
      3. Set up a password (optional). Current Wi-Fi networks are open.

   4. Test the setup by connecting the computer to the created Wi-Fi network and logging back into the browser GUI.

4. Connect RPi to the router using an Ethernet cable. Note that the DHCP Server will assign a random IP address to the RPi and other devices connected to it.

5. Set up address reservation (fixed IP address) for RPi

   1. Go to Advanced > Network > DHCP Server
   2. In the DHCP Client List, find the current IP address of the RPi or open a terminal in the RPi and type `ifconfig`. You will get something like this: <br><br>![](/router-manual/ifconfig-current.png)<br><br>

   > eth0 is the LAN (wired) interface.
   >
   > - IP address is squared in red
   > - MAC address in squared in blue

   3. In the Address Reservation section, click Add and enter the desire IP address and MAC address of the RPi and save the settings.

<!-- Maybe we should suggest doing this after the router setup -->

## III. Pi Initialization

1. Gather Hardware:

   1. SD Card w/ Pi OS
   2. Power Cable
   3. Ethernet Cable
   4. Peripherals (as needed)
   5. Your Raspberry Pi

2. Connect to Pi (**SSH** or **Peripherals**)

   **SSH**

   1. Power the Pi and connect ethernet to the same network as the device performing SSH
      > **NOTE ON USING ENTERPRISE NETWORKS:**<br> You cannot use enterprise networks such as UCF WPA or eduroam. The Raspberry Pi, even with significant edits to the config files cannot > reliably connect to such networks. Trust us, we've tried.
   2. SSH to the Pi with `ssh emurr@emurr.local`
      > **If this step does not work:**<br> Get the Pi's IP address by pinging `ping emurr.local`
      >
      > > **If this still does not work:**<br>
      > >
      > > 1. Ensure the Imager was configured with a proper `hostname`
      > > 2. Ensure you are **not** on an enterprise network
      > > 3. Alternatively, you may want to do this step only after you have set up the router and established a static IP address
   3. Enter password as specified in your Pi Imager configuration

   **Peripherals**

   1. Power the Pi and connect peripherals (HDMI, Desktop, & USB Keyboard)
   2. Login with the password specified in your Pi Imager configuration

3. Install & Initialize NGINX
   1. Install NGINX on the Raspberry Pi by running `sudo apt-get install nginx`
   2. Start the NGINX server with `sudo systemctl start nginx`
      > You may verify NGINX status with `sudo systemctl status nginx`<br><br> For more help visit NGNIX docs here:<br> > https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#installing-prebuilt-debian-packages
4. Update the folders on the Raspberry Pi as instructed for each of these folders on this repository  
    **rpi/root/**<br> The contents of this folder should be unloaded to the root `~/` directory

   **rpi/html/**<br> The contents of this folder should be unloaded to the `/var/www/html` directory

   **rpi/nginx-config/**<br> The contents of this folder should **replace** the nginx configs `/etc/nginx/sites-available/default` file
