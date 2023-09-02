{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = {self, nixpkgs}: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    unwrapped = pkgs.callPackage ./runtime-build.nix;
    getOverrides = version: gccVersion: hash: {
      inherit version;
      src = pkgs.requireFile {
        name = "houdini-${version}-linux_x86_64_gcc${gccVersion}.tar.gz";
        sha256 = hash;
        url = "https://www.sidefx.com/download/daily-builds/?production=true";
      };
    };
    houdiniBase = pkgs.callPackage ./. {};
  in{
    packages.x86_64-linux = rec {
      "houdini-19_0_720" = houdiniBase.override (super: {
        unwrapped = unwrapped (
          getOverrides "19.0.720" "9.3" "d580ab699a13bae0f4d096dc090013b27095ca6ef9f3ff65d4be824ab30f4256"
       );
      });

      "houdini-19_5_569" = houdiniBase.override (super: {
        unwrapped = unwrapped (
          getOverrides "19.5.569" "9.3" "0c2d6a31c24f5e7229498af6c3a7cdf81242501d7a0792e4c33b53a898d4999e"
       );
      });
      "houdini-19_5_640" = houdiniBase.override (super: {
        unwrapped = unwrapped (
          getOverrides "19.5.640" "9.3" "37ffda14340a66dab9243885a4a4b138a6d61a1008732f664a053c37790146a4"
        );
      });
      "houdini-19_5_716" = houdiniBase.override (super: {
        unwrapped = unwrapped (
          getOverrides "19.5.716" "9.3" "b9177d5432d44de5aed7b266d2af435ac8a294d9654fb1915e2a7363fad3872e"
        );
      });

      default = "houdini-19_5_569";
    };
  };
}
