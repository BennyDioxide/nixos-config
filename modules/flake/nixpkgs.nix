{ inputs, ... }:
let
  inherit (inputs) self;
in
{
  debug = true;
  perSystem =
    { lib, system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "electron-27.3.11" # EOL
          "dotnet-sdk-7.0.410" # EOL
          "dotnet-sdk-wrapped-7.0.410" # EOL
          "dotnet-runtime-7.0.20" # EOL
          "dotnet-runtime-wrapped-7.0.20" # EOL
        ];
        # config.permittedInsecurePackages = [ "electron-28.3.3" ];
        overlays = lib.attrValues self.overlays ++ [
          inputs.rust-overlay.overlays.default
          inputs.niri.overlays.niri
        ];
      };
    };
}
