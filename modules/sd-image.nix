{ lib, config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
    ./profile.nix
  ];

  system.stateVersion = "22.05"; # Did you read the comment?

  sdImage = {
    imageBaseName = "odroid-n2";
    #compressImage = false;
    populateFirmwareCommands = lib.mkOverride 0 '''';
  };
  
}
