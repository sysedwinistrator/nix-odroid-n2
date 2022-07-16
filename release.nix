{ nixpkgs ? <nixpkgs>,
  broken ? false,
}:

with (import nixpkgs {}).lib;

let

  targetSystem = "aarch64-linux";

  sdImageConfig = import (nixpkgs+"/nixos/lib/eval-config.nix") {
     modules = [
       ./modules/sd-image.nix
       (if (targetSystem == builtins.currentSystem) then {}
       else ./cross.nix)
     ];
  };

  mkJob  = { select, system ? builtins.currentSystem }: select (import nixpkgs (
    if (targetSystem == system) then { inherit system; }
    else { crossSystem = targetSystem; }
  ));

  jobs = (optionalAttrs (builtins.currentSystem == "x86_64-linux" || broken) rec {

    uboot = mkJob { select = pkgs: (pkgs.callPackage ./packages/uboot_odroid_n2 pkgs); };

    fip = mkJob { select = pkgs: (pkgs.callPackage ./packages/fip (pkgs // { inherit uboot; })); };

 });
in
{
  inherit (sdImageConfig.config.system.build)
     toplevel
     sdImage;

} // jobs
