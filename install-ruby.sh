#!/bin/bash

set -e
set -x

CHRUBY_VER="0.3.9"
CHRUBY_URL=https://github.com/postmodern/chruby/archive/v${CHRUBY_VER}.tar.gz
RUBY_INSTALL_VER="0.5.0"
RUBY_INSTALL_URL=https://github.com/postmodern/ruby-install/archive/v${RUBY_INSTALL_VER}.tar.gz

echo "Installing chruby v${CHRUBY_VER}..."
wget -O chruby-${CHRUBY_VER}.tar.gz https://github.com/postmodern/chruby/archive/v${CHRUBY_VER}.tar.gz
tar -xzvf chruby-${CHRUBY_VER}.tar.gz
cd chruby-${CHRUBY_VER}/
scripts/setup.sh
cd ..
rm -rf chruby-${CHRUBY_VER}/
rm chruby-${CHRUBY_VER}.tar.gz

echo "Installing ruby-install v${RUBY_INSTALL_VER}..."
wget -O ruby-install-${RUBY_INSTALL_VER}.tar.gz $RUBY_INSTALL_URL
tar -xzvf ruby-install-${RUBY_INSTALL_VER}.tar.gz
cd ruby-install-${RUBY_INSTALL_VER}/
make install
cd ..
rm -rf ruby-install-${RUBY_INSTALL_VER}/
rm ruby-install-${RUBY_INSTALL_VER}.tar.gz

install_ruby() {
    local version=$1
    local sha=$2

    echo "Installing ruby $version..."
    ruby-install --sha256 "$sha" ruby "$version"

    source /etc/profile.d/chruby.sh

    chruby "ruby-$version"
    ruby -v
    gem update --system
}

install_ruby 2.6.2 a0405d2bf2c2d2f332033b70dff354d224a864ab0edd462b7a413420453b49ab
install_ruby 2.4.3 0a703dffb7737f56e979c9ebe2482f07751803c71e307c20446b581e0f12cf30
