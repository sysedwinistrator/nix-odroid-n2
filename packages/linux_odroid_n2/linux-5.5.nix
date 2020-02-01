{ stdenv, callPackage, fetchurl, modDirVersionArg ? null, ... } @ args:

with stdenv.lib;

with (import ./patch/default.nix stdenv.lib);

let
  configfile = ./linux-5.5.config;

  version = "5.5";
  branch = versions.majorMinor version;
  src = fetchurl {
    url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
    sha256 = "0c131fi6s7vgvka1c0597vnvcmwn1pp968rci5kq64iwj3pd9yx6";
  };
  # modDirVersion needs to be x.y.z, will always add .0
  modDirVersion = "5.5.0";
  # modDirVersion = if (modDirVersionArg == null) then concatStringsSep "." (take 3 (splitVersion "${version}.0")) else modDirVersionArg;

  kernelPatches = (patchsets [
    "armbian/5.5"
    "libre/5.5"
    "khadas/5.4"
  ]);

in (callPackage ./generic.nix (args // {
    inherit src version modDirVersion configfile kernelPatches branch;
}))
