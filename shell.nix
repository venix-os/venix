with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "venix";
  buildInputs = [
    rustup qemu nasm gcc grub2 xorriso
  ];
  shellHook = ''
    rustup default nightly
    rustup component add rust-src
    export NIX_ENFORCE_PURITY=0
    cargo install xargo
    cargo install cargo-xbuild
    export PATH=$PATH:$HOME/.cargo/bin
  '';
  RUST_BACKTRACE = 1;
}
