{ pkgs, ... }: {
  home.packages = [
    (pkgs.python3.withPackages (ps: with ps; [
    	pip
    	setuptools
    	numpy
    	pandas
    	matplotlib
    	pillow
    	pytest
    	requests
    	scipy
    	sympy
    	wheel
    ]))
  ];
}
