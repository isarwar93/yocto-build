# yocto-build

This repo will be taking showing steps that how to do yocto build in a Docker enviroment. This yocto build will be used for Pico-IMX-7 module from TechNexion.

To read further about Pico-IMX7 module follow the link below:

https://www.technexion.com/products/system-on-modules/pico/pico-imx7/

## Advantages of Yocto building

First question comes into mind, why going though a hard way of building Yocto instead directly flashing some common Linux OS into the embedded modules. The short answer would be flexibility.

Yocto building gives access to control the packages that a user want to flash in an Embedded modules, which are having limited spaces. So that a user can flash only the packages that they actually want to use in their end product.

## Disadvantages of Yocto building

Long and painful time of waiting to finish the building.