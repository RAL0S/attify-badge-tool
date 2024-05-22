#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/attify/attify-badge-tool/releases/download/v0.0.1/Attify.Badge.Tool-0.0.1-x86_64.AppImage -O $RALPM_TMP_DIR/Attify.Badge.Tool-0.0.1-x86_64.AppImage
  mv $RALPM_TMP_DIR/Attify.Badge.Tool-0.0.1-x86_64.AppImage $RALPM_PKG_INSTALL_DIR/Attify.Badge.Tool-0.0.1-x86_64.AppImage
  chmod +x $RALPM_PKG_INSTALL_DIR/Attify.Badge.Tool-0.0.1-x86_64.AppImage
  ln -s $RALPM_PKG_INSTALL_DIR/Attify.Badge.Tool-0.0.1-x86_64.AppImage $RALPM_PKG_BIN_DIR/attify-badge-tool
}

uninstall() {
  rm $RALPM_PKG_INSTALL_DIR/Attify.Badge.Tool-0.0.1-x86_64.AppImage
  rm $RALPM_PKG_BIN_DIR/attify-badge-tool
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1