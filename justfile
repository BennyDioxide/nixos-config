set shell := [ "nu", "-c" ]

alias s := switch
alias sh := switch-home
alias u := update-nixpkgs
alias ua := update-all-inputs
alias gc := clean
alias c := clean
alias ca := clean-all
alias op := optimise
alias optimize := optimise

default: switch-home

switch:
	nh os switch . --ask
# sudo nixos-rebuild switch --flake .#benny-nixos

switch-home:
	nh home switch . --ask
# home-manager switch --flake .#benny
#...(if {{ backup }} { [-b backup] } else { [] })

boot:
	nh os boot

update-all-inputs:
	nix flake update

update-nixpkgs:
    nix flake lock --update-input nixpkgs
#	nix flake update nixpkgs

update-nixpkgs-master:
    nix flake lock --update-input nixpkgs-master
#	nix flake update nixpkgs-master

update: update-nixpkgs switch

clean:
	nix store gc
# nh clean user

gc-legacy:
	sudo nix-collect-garbage -d

_clean-all:
    nh clean all

clean-all: _clean-all reinstall-hm

optimise:
	nix store optimise

wipe-profile:
	nix profile wipe-history

expire-week:
	home-manager expire-generations 7

reinstall-hm:
	nix run home-manager/master -- switch --flake .
