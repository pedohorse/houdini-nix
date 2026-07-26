{
  version,
  srcHash,
  autoPatchelfHook,
  gnused,
  gnutar,
  stdenv,
  requireFile,
  libx11,
  libxkbcommon,
  libGLX,
  libsm,
  libice,
  libxcb-wm,
  libxcb-cursor,
  libxcb-keysyms,
  dbus,
  libxcb,
  installLauncher ? false,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "houdini-launcher";
  inherit version srcHash;

  src = requireFile {
    name = "install_houdini_launcher.sh";
    sha256 = finalAttrs.srcHash;
    url = "https://www.sidefx.com/download/daily-builds/?production=true";
  };
  
  nativeBuildInputs = [
    autoPatchelfHook
    gnutar
    gnused
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ] ++ (if installLauncher then [
    libx11
    libxkbcommon
    libGLX
    libsm
    libice
    libxcb
    libxcb-wm
    libxcb-cursor
    libxcb-keysyms
    dbus
  ] else []);
  

  unpackPhase = ''
    cp $src ./''$(stripHash $src)
  '';

  dontConfigure = true;
  autoPatchelfIgnoreMissingDeps = true;

  buildPhase = ''
    install_scope=system
    installdir=$out
    tar_flags="-xvz"
    script=./install_houdini_launcher.sh
    mkdir -p $out
    sed -e "1,/^#DATA#$/d" -- "''${script}" | ( cd "''${installdir}" && tar ''${tar_flags} -f - )
    mv $out/.new $out/${finalAttrs.version}

    printf "%s" "{\"install_scope\":\"''${install_scope}\"}" > "''${installdir}/install_config.json"
  '' + (if installLauncher then "" else ''
    # cleanup everything but installer
    rm $out/bin/houdini_launcher
    rm $out/${finalAttrs.version}/bin/houdini_launcher
    rm $out/${finalAttrs.version}/hserver.iso
    rm $out/uninstall_houdini_launcher.sh
  '');

})
