{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = {self, nixpkgs}: 
  let
    pkgs = import nixpkgs {
      config.allowUnfree = true;
      system = "x86_64-linux";
    };
    unwrapped = pkgs.callPackage ./runtime-build.nix;
    getOverrides = { version, eulaDate, gccVersion, hash }: {
      inherit version eulaDate;
      src = pkgs.requireFile {
        name = "houdini-${version}-linux_x86_64_gcc${gccVersion}.tar.gz";
        sha256 = hash;
        url = "https://www.sidefx.com/download/daily-builds/?production=true";
      };
    };
    houdiniBase = pkgs.callPackage ./. {};
    sesinetdBase = pkgs.callPackage ./sesinetd.nix {};
  in {
    packages.x86_64-linux =
      pkgs.lib.attrsets.mergeAttrsList (
        builtins.map ({suffix, overriddenVersion}: {
          "houdini-${suffix}" = houdiniBase.override overriddenVersion;
          "sesinetd-${suffix}" = sesinetdBase.override overriddenVersion;
        }) (import ./versionOverrides.nix {inherit unwrapped getOverrides;})
      );
    nixosModules = rec {
      sesinetd = import ./nixos_modules/sesinetd.nix;
      default = sesinetd;
    };
  };
}
