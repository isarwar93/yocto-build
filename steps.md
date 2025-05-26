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