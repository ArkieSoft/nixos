{ pkgs, vimUtils, fetchFromGitHub }:
vimUtils.buildVimPlugin {
  pname = "indent-rainbowline.nvim";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "ArkieSoft";
    repo = "indent-rainbowline.nvim";
    rev = "4977a9735583f13d5c1114f373342745dd35b3b4";
    sha256 = "/YCovZOi+SbXHDnvazQAnqSL8ygaJzmHm6RzvlQ+phI=";
  };
  meta.homepage = "https://github.com/TheGLander/indent-rainbowline.nvim";
}

