{ system ? builtins.currentSystem, pkgs ? import <nixpkgs> { inherit system; } }:
 
pkgs.python3Packages.buildPythonApplication {
	pname = "transcript";
	version = "1.0";
	pyproject = true;
	src = ./.;
	propagatedBuildInputs = with pkgs.python3Packages; [
	    setuptools
			i3ipc
	  ];
}

