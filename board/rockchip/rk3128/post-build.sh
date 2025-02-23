#!/bin/sh

BOARD_DIR="$(dirname $0)"

install -m 0644 -D $BOARD_DIR/extlinux.conf $BINARIES_DIR/extlinux/extlinux.conf
#install -m 0644 -D $BOARD_DIR/rk3128-idbloader.img $BINARIES_DIR/idbloader.img
#install -m 0644 -D $BOARD_DIR/rk3128-trust.img $BINARIES_DIR/trust.img
#install -m 0644 -D $BOARD_DIR/rk3128-uboot.img $BINARIES_DIR/uboot.img
