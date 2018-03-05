SUMMARY = "Firewall for rpi"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SCR_URI = "file://firewall.sh file://firewall.service"

S= "${WORKDIR}"

inherit update-rc.d systemd

do_install() {
    install -d ${D}${bindir}
    install -m 0755 firewall.sh ${D}${bindir}
    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/firewall.service ${D}${systemd_unitdir}/system
}

INITSCRIPT_NAME = "firewall.sh"
INITSCRIPT_PARAMS = "start 99 5 2 . stop 19 0 1 6 ."

SYSTEMD_SERVICE_${PN} = "firewall.service"

