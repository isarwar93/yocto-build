To have more libraries and functionalities in yocto image we need to add few more stuff in conf/local.conf file inside yocto build: 

-> In the end of conf/local.conf
```
CORE_IMAGE_EXTRA_INSTALL += " openssh"
CORE_IMAGE_EXTRA_INSTALL += " dbus"
CORE_IMAGE_EXTRA_INSTALL += " glib-2.0 bluez5"
CORE_IMAGE_EXTRA_INSTALL += " nginx"

```

-> in conf/bblayers.conf for nginx

```
${BSPDIR}/sources/meta-openembedded/meta-webserver \
```
