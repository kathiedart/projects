# This file has been generated by node2nix 1.8.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "esm-3.2.25" = {
      name = "esm";
      packageName = "esm";
      version = "3.2.25";
      src = fetchurl {
        url = "https://registry.npmjs.org/esm/-/esm-3.2.25.tgz";
        sha512 = "U1suiZ2oDVWv4zPO56S0NcR5QriEahGtdN2OR6FiOG4WJvcjBVFB0qI4+eKoWFH483PKGuLuu6V8Z4T5g63UVA==";
      };
    };
    "fantasy-birds-0.1.0" = {
      name = "fantasy-birds";
      packageName = "fantasy-birds";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fantasy-birds/-/fantasy-birds-0.1.0.tgz";
        sha1 = "5a9bf908dde0ccc2c716afa8c303e7e6cf1fd3c2";
      };
    };
    "fantasy-combinators-git+https://github.com/fantasyland/fantasy-combinators.git" = {
      name = "fantasy-combinators";
      packageName = "fantasy-combinators";
      version = "0.0.2";
      src = fetchgit {
        url = "https://github.com/fantasyland/fantasy-combinators.git";
        rev = "cd33feaf77c2400447b1de0586e1baadcf1aabfc";
        sha256 = "db5fdeeabf7850929115e324d7b04b60fe388bf844570d64b69baf11cfbf96a8";
      };
    };
    "fantasy-helpers-0.0.1" = {
      name = "fantasy-helpers";
      packageName = "fantasy-helpers";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/fantasy-helpers/-/fantasy-helpers-0.0.1.tgz";
        sha1 = "f9fddaf9769878ad11141238ec1b0b8a50cc8038";
      };
    };
  };
  args = {
    name = "beprs";
    packageName = "beprs";
    version = "1.0.0";
    src = ./.;
    dependencies = [
      sources."esm-3.2.25"
      sources."fantasy-birds-0.1.0"
      sources."fantasy-combinators-git+https://github.com/fantasyland/fantasy-combinators.git"
      sources."fantasy-helpers-0.0.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "";
      license = "AGPL-3.0";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
in
{
  args = args;
  sources = sources;
  tarball = nodeEnv.buildNodeSourceDist args;
  package = nodeEnv.buildNodePackage args;
  shell = nodeEnv.buildNodeShell args;
}