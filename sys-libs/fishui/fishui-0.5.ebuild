# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/fishui.git"
	EGIT_CHECKOUT_DIR=${PN}-${PV}
else
	SRC_URI="https://github.com/cutefishos/fishui/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/HougeLangley/cutefishos-overlay/releases/download/v0.5-patches/fixed_QApplication.patch -> v0.5-fixed_QApplication.patch"
	KEYWORDS="amd64 arm64 riscv"
fi

DESCRIPTION="GUI library based on QQC2 for Cutefish applications"
HOMEPAGE="https://github.com/cutefishos/fishui"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	kde-frameworks/kwindowsystem
	dev-qt/qtquickcontrols2[widgets]
"
BDEPEND="${DEPEND}
	kde-frameworks/extra-cmake-modules
	dev-util/ninja
	dev-qt/linguist-tools[qml]
	dev-qt/assistant
	dev-qt/designer
	dev-qt/qdbusviewer
"

S="${WORKDIR}/${PN}-${PV}"

src_prepare(){
	if [[ ${PV} != 9999* ]]; then
	eapply "${DISTDIR}/v0.5-fixed_QApplication.patch"
	fi
	
	cmake_src_prepare
}

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
