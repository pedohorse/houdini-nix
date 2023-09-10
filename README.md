my fork of houdini package from nixpkgs

all important changes are pushed to nixpkgs

# Building

To be able to build houdini you need to download a corresponding build installer from [sidefx site](https://www.sidefx.com/download/daily-builds/?production=true)

Add downloaded installer to the store with `nix-store --add-fixed sha256 houdini-19.0.720-linux_x86_64_gcc9.3.tar.gz` (with proper filename of course)

then you can install and build corresponding houdini version with

`nix build .#houdini-19_0_720`

# Running

After building, you will have the usual `result` symlink created. all (hopefully) important binaries are exposed in `./result/bin` directory

`sesinetd` is exposed at `./result/houdini/sbin/sesinetd`, you can run it as usual if you need a license version. Also read notes below.

# Notes:

currently this flake provides onlt the following versions:

* 19.0.720
* 19.5.569
* 19.5.640
* 19.5.716

### On sesinetd:

sesinetd tries to save licensing data at `/usr/lib/sesi/licenses`, which is NOT writable (nor should it be) from the bubblewrap sandbox in which houdini runs.

`sesinetd` does not seem to provide options to change that particular location, but it can easily binded. So far I did not need a solution for that, so it's left as is.

