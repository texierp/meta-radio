DESCRIPTION = "Basic project Monitoring image"
LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += "ssh-server-dropbear"
IMAGE_INSTALL += "  \
        apache2\
        


"

export IMAGE_BASENAME = "base-image-radio"