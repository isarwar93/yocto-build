# Steps to get Yocto build

1. Install docker: 

```
sudo snap install docker
```

2. Build the docker

```
docker build -t yocto-bsp-env .
```

3. To run the docker and have the docker data save in local workspace and to detach the docker with the terminal:

```
docker run -dit --name yocto-dev \
  -v $HOME/yocto-workspace:/home/yoctouser/temp \
  yocto-bsp-env
```

4. For later attach the terminal with docker or start or stop using following commands:

```
sudo docker start -ai yocto-dev # To start the container
sudo docker start yocto-dev  # to start container detached
docker exec -it yocto-dev bash  # To enter the container
docker stop yocto-dev           # To stop the container
```

5. Add your user to the docker group

```
sudo groupadd docker

sudo usermod -aG docker $USER
```


6. Add git global config:

```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

7. Through following lines BSP sources needs to be downloaded

```
mkdir edm_yocto
cd edm_yocto
repo init -u https://github.com/TechNexion/tn-imx-yocto-manifest.git -b scarthgap_6.6.y-stable -m imx-6.6.52-2.2.0.xml
repo sync -j$(nproc)
```


8. Run following command to set what option would like to add:

```
WIFI_FIRMWARE=y WIFI_MODULE=qca DISTRO=fsl-imx-wayland MACHINE=pico-imx7 BASEBOARD=pi source tn-setup-release.sh -b build-wayland-pico-imx7
bitbake core-image-base
```


9. For the cross compiling, following command is required:

```
bitbake core-image-base -c populate_sdk
```

10. It will create following .sh file depending upon the Yocto version name in /tmp/deploy/sdk:

```
fsl-imx-wayland-glibc-x86_64-core-image-base-cortexa7t2hf-neon-pico-imx7-toolchain-6.6-scarthgap.sh
```

11. Then run the following commands:

```
chmod +x **.sh
./**.sh
```

12. Set the target directory, when it will output something like following:

```
TechNexion i.MX Release Distro SDK installer version 6.6-scarthgap
==================================================================
Enter target directory for SDK (default: /opt/fsl-imx-wayland/6.6-scarthgap): 
```

13. Source the environment script

Once installed:

source /opt/poky/xxx/environment-setup-cortexa7t2hf-neon-<machine>

In our case:

```
source /opt/fsl-imx-wayland/6.6-scarthgap/environment-setup-cortexa7t2hf-neon-poky-linux-gnueabi 
```

This sets:

    CC, CXX, LD, etc.

    PKG_CONFIG_PATH, CFLAGS, LDFLAGS, etc.

To verify:
```
echo $CC
```
# Should show something like arm-poky-linux-gnueabi-gcc