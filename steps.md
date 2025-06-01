# Steps to get Yocto build

-> Install docker: 

See docker-install file


-> Build the docker

```
docker build -t yocto-bsp-env .
```

-> To run the docker and have the docker data save in local workspace and to detach the docker with the terminal:

```
docker run -dit --name yocto-dev \
  -v $HOME/yocto-workspace:/home/yoctouser/temp \
  yocto-bsp-env
```
or with port 22:
```
docker run -dit --name yocto-dev \
  -p 2222:22 \
  -v $HOME/yocto-workspace:/home/yoctouser/temp \
  yocto-bsp-env
```


-> To check which docker images are present including stopped ones
```
docker ps -a
docker image ls
docker images
```

-> For later attach the terminal with docker or start or stop using following commands:


```
sudo docker start -ai yocto-dev   # To start the container
sudo docker start yocto-dev       # To start container detached
docker exec -it yocto-dev bash    # To enter the container
docker stop yocto-dev             # To stop the container
```

-> Add your user to the docker group

```
sudo groupadd docker

sudo usermod -aG docker $USER
```


-> Add git global config:

```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

-> Through following lines BSP sources needs to be downloaded

```
mkdir edm_yocto
cd edm_yocto
repo init -u https://github.com/TechNexion/tn-imx-yocto-manifest.git -b scarthgap_6.6.y-stable -m imx-6.6.52-2.2.0.xml
repo sync -j$(nproc)
```


-> Run following command to set what option would like to add:

```
WIFI_FIRMWARE=y WIFI_MODULE=qca DISTRO=fsl-imx-wayland MACHINE=pico-imx7 BASEBOARD=pi source tn-setup-release.sh -b build-wayland-pico-imx7
bitbake core-image-base
```


-> For the cross compiling, following command is required:

```
bitbake core-image-base -c populate_sdk
```

-> It will create following .sh file depending upon the Yocto version name in /tmp/deploy/sdk:

```
fsl-imx-wayland-glibc-x86_64-core-image-base-cortexa7t2hf-neon-pico-imx7-toolchain-6.6-scarthgap.sh
```

-> Go to the folder, and find /tmp/deploy/sdk and there run the following commands:

```
chmod +x **.sh
./**.sh
```

-> Set the target directory, when it will output something like following:

```
TechNexion i.MX Release Distro SDK installer version 6.6-scarthgap
==================================================================
Enter target directory for SDK (default: /opt/fsl-imx-wayland/6.6-scarthgap): 
```

-> Source the environment script

Once installed it should show something like this:

```
Enter target directory for SDK (default: /opt/fsl-imx-wayland/6.6-scarthgap): 
You are about to install the SDK to "/opt/fsl-imx-wayland/6.6-scarthgap". Proceed [Y/n]? y
Extracting SDK..........................................................................................................................................................done
Setting it up...done
SDK has been successfully set up and is ready to be used.
Each time you wish to use the SDK in a new shell session, you need to source the environment setup script e.g.
 $ . /opt/fsl-imx-wayland/6.6-scarthgap/environment-setup-cortexa7t2hf-neon-poky-linux-gnueabi
```

Therefor, we need to source the compiler

source /opt/poky/xxx/environment-setup-cortexa7t2hf-neon-<machine>

-> In our case:

```
source /opt/fsl-imx-wayland/6.6-scarthgap/environment-setup-cortexa7t2hf-neon-poky-linux-gnueabi 
```

This sets: CC, CXX, LD, ,PKG_CONFIG_PATH, CFLAGS, LDFLAGS, etc.

-> To verify:
```
echo $CC
```
Should show something like arm-poky-linux-gnueabi-gcc

-> further modifications can be done in the following files:

# TechNexion setup-environment.sh wrapper: Further modification to bblayers.conf and local.conf

# setup i.MX Yocto Project Release layers in bblayers.conf
# setup TechNexion i.MX Yocto Project Release Layers in bblayers.conf
# setup TechNexion wifi layer in bblayers.conf
# setup TechNexion vizionsdk layer in bblayers.conf
# setup NXP nfc release layer in bblayers.conf
