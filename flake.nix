{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = {self, nixpkgs}: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in{
    packages.x86_64-linux = rec {
      houdini = pkgs.callPackage ./. {};
      default = houdini;
    };
  };
}
