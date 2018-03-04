SUMMARY = "Firewall for rpi"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SCR_URI = "file://firewall.sh \
            file://firewall.service \
            "
s= "${WORKDIR}"

inherit systemd 

do_install_append(){
    install -d ${D}${sysconfdir}/init.d/
    install -m 0755 ${WORKDIR}/firewall.sh ${D}${sysconfdir}/init.d/

    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/firewall.service ${D}${systemd_unitdir}/system

}

INITSCRIPT_NAME = "firewall.sh"
INITSCRIPT_PARAMS = "start . stop ."

SYSTEMD_SERVICE_${PN} = "firewall.service"

FILE_${PN} = "${datadir}/*"