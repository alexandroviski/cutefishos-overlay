# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/core.git"
	EGIT_CHECKOUT_DIR=core-${PV}
else
	SRC_URI="https://github.com/cutefishos/core/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64 riscv"
fi

DESCRIPTION="System components and backend of CutefishOS"
HOMEPAGE="https://github.com/cutefishos/core"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	sys-libs/fishui
	media-sound/pulseaudio
	x11-libs/libXtst
	sys-auth/polkit-qt
	x11-drivers/xf86-input-libinput
	x11-drivers/xf86-input-synaptics
	x11-misc/appmenu-gtk-module
"
BDEPEND="${DEPEND}
	kde-frameworks/extra-cmake-modules
	dev-util/ninja
	dev-qt/linguist-tools[qml]
	dev-qt/assistant
	dev-qt/designer
	dev-qt/qdbusviewer
"

S="${WORKDIR}/core-${PV}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
