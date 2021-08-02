# Install Dynare on Linux

This repository contains a small, but verbose, Bash script that downloads, unpacks, configures and compiles an installation of [Dynare](https://www.dynare.org/) on a Debian-based Linux machine with [MATLAB](https://www.mathworks.com/products/matlab.html) installed.


## Requirements

- A working installation of MATLAB.
- A Debian-based machine.
    | Should work on | Tested?            |
    |----------------|:------------------:|
    | Ubuntu 20.04   | :heavy_check_mark: |
    | Ubuntu 18.04   | :question:         |
    | Debian 10      | :question:         |


## Description

The script will ask the following information:
- Dynare version: Can be verified by going to https://www.dynare.org/release/source/. For example, `4.5.7`.
- Path to MATLAB: Can be verified by executing `matlabroot` in the MATLAB prompt. For example, `/usr/local/MATLAB/R2020b`.
- MATLAB version: Can be verified by executing `version` in the MATLAB prompt. For example, `9.9`.

The script performs the following actions:
- It ensures that the Debian-based machine on which this runs provides all the necessary dependencies.
- It downloads a `.tar.xz` from https://www.dynare.org/release/source/, depending on the Dynare version requested.
- It unpacks the downloaded tarball into `$HOME/.dynare/x.y.z`, where `x.y.z` is the Dynare version requested.
- It runs the `./configure` command with appropriate flags. In particular, it suppresses debugging information from being displayed, it specifies not to use Octave and it provides the relevant MATLAB information.
- It runs the `make` command, which in turn compiles the source code into the relevant executables.
- Reminds the user to run `addpath('~/.dynare/x.y.z/matlab')` in the MATLAB prompt in order to use Dynare in MATLAB.

The script does NOT perform the following:
- Compile an Octave-compatible version of Dynare.
- Compile a local version of the documentation.
- Run the test suite to verify that everything is in order after compilation.
- Provide any insurance or warranty about the product that is eventually installed on your machine.


## Removal, if necessary

This script only leaves traces in `$HOME/.dynare/`.
To remove any trace left from this script, simply run
```shell
rm -rf ~/.dynare/x.y.z
```
where `x.y.z` is the Dynare version you have installed.


## Potential improvements to implement

- There is a one-to-one mapping between the MATLAB Release number and its version. For example [[source]](https://www.mathworks.com/products/compiler/matlab-runtime.html):

    | Release | Version |
    |---------|---------|
    | R2021a  | 9.10    |
    | R2020b  | 9.9     |
    | R2020a  | 9.8     |
    | R2019b  | 9.7     |
    | R2019a  | 9.6     |
    | R2018b  | 9.5     |
    
    First, one could be asked the release number and not the version, as it is more straightforward to know the release.
    Second, there could be a default option to read the release information from the path of the MATLAB installation, as the default paths usually end with the release number.
    Addressing this requires hard-coding the map release-version into the script, which I am too lazy for.
- Idk, Pull Requests welcome!


## Disclaimer

As per the [License](./LICENSE), no warranty is provided about the reliability of the software in this repository.
In particular, users of such software should not trust that the resulting Dynare installation is a working one.

Dynare is free software, see the related [license file](https://git.dynare.org/Dynare/dynare/-/blob/master/license.txt).

MATLAB is a trademark of _The Mathworks, Inc._
Lawful use of MATLAB requires a license, which can be bought at https://www.mathworks.com/products/matlab.html.
