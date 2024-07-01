# knixpkgs

## Usage as a flake

[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/Karitham/knixpkgs/badge)](https://flakehub.com/flake/Karitham/knixpkgs)

Add knixpkgs to your `flake.nix`:

```nix
{
  inputs.knixpkgs.url = "https://flakehub.com/f/Karitham/knixpkgs/*.tar.gz";

  outputs = { self, knixpkgs }: {
    # Use in your outputs
  };
}
```
