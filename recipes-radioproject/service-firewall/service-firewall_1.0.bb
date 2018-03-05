SUMMARY = "Firewall for rpi"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = " \
	file://firewall.sh \
	file://firewall.service \
"

S= "${WORKDIR}"

inherit systemd

do_install() {
    install -d ${D}${bindir}
    install -m 0755 firewall.sh ${D}${bindir}
    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/firewall.service ${D}${systemd_unitdir}/system
}

SYSTEMD_SERVICE_${PN} = "firewall.service"

