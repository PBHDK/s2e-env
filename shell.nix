# to update get a commit from here https://status.n#ixos.org/
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/b38db2c901b30a37d345751f4f6418d416e7e46e.tar.gz") { } }:
with pkgs;
let
  aarch64 = pkgsCross.aarch64-multiplatform;
in
aarch64.stdenv.mkDerivation {
  name = "s2e-env-nix";
  nativeBuildInputs = aarch64.linux.nativeBuildInputs;
  depsBuildBuild = with aarch64.buildPackages; [
    python311
    python311.pkgs.setuptools
    python311.pkgs.devtools
    python311.pkgs.autopep8
    python311.pkgs.pip
    stdenv.cc
    pkgs.gnupg

    # Deps from dat/config.yml start here
    pkgs.cmake
    pkgs.wget
    pkgs.curl
    pkgs.texinfo
    pkgs.flex
    pkgs.bison
    pkgs.autoconf

    # Image build dependencies
    pkgs.libguestfs
    pkgs.cdrkit # genisoimage
    pkgs.xz
    pkgs.docker
    pkgs.p7zip
    pkgs.hivex
    pkgs.jigdo
    pkgs.cloud-utils

    # S2E dependencies
    pkgs.libdwarf.dev
    pkgs.libelf
    # pkgs.libelf-dev-i386
    pkgs.libiberty.dev
    pkgs.binutils
    pkgs.readline.dev
    pkgs.boost
    pkgs.zlib.dev
    # pkgs.jemalloc.dev
    pkgs.nasm
    pkgs.pkg-config
    pkgs.memcached
    # pkgs.libvdeplug.dev
    pkgs.libpqxx
    # pkgs.libc6-dev-i386
    # pkgs.libboost-system-dev
    # pkgs.libboost-serialization-dev
    # pkgs.libboost-regex-dev
    pkgs.protobuf
    # pkgs.protobuf-compiler
    pkgs.libbsd.dev
    pkgs.libsigcxx
    pkgs.glib.dev
    # pkgs.libglib2-0-dev-i386
    # pkgs.libglib2-0-0-i386
    # pkgs.pkgsCross.mingwW64
    pkgs.qemu
    pkgs.gccMultiStdenv
    pkgs.gpp
    pkgs.pixman
    pkgs.saw-tools # pkgs.libtinfo5
    pkgs.libpng.dev

    # s2e-env dependencies
    pkgs.lcov
    pkgs.jq

    # common ubuntu 
    pkgs.wine

    # ubuntu 22
    pkgs.fuse3
    python311.pkgs.docutils
    pkgs.SDL2.dev
  ];
  buildInputs = [ ];
  hardeningDisable = [ "all" ];
  # FIXME: sourcing the venv is working, but it's not being picked up by zsh        
  shellHook =
    ''
      source venv/bin/activate
      export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
    '';
}
