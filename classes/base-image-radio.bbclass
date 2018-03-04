DESCRIPTION = "Basic project Monitoring image"
LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += "ssh-server-dropbear"
IMAGE_INSTALL += "  \
        dnsmasq \
        hostapd \
        wpa-supplicant \
        wpa-supplicant-passphrase \
        openssh-sftp-server \
"

export IMAGE_BASENAME = "base-image-radio"