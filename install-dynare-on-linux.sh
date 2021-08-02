#!/bin/bash

# Ensure build dependencies are satisfied
sudo apt install \
build-essential \
gfortran \
liboctave-dev \
libboost-graph-dev \
libgsl-dev \
libmatio-dev \
libslicot-dev \
libslicot-pic \
libsuitesparse-dev \
flex \
bison \
autoconf \
automake \
texlive \
texlive-publishers \
texlive-latex-extra \
texlive-fonts-extra \
texlive-latex-recommended \
texlive-science \
texlive-plain-generic \
lmodern \
python3-sphinx \
latexmk \
libjs-mathjax \
doxygen \
x13as

# Define variables for later use
download_dir=$HOME/.tmp
install_dir=$HOME/.dynare

# Ask what version of Dynare is desired
echo ""
echo "What Dynare version would you like to install?"
echo "Enter X.Y.Z, where each XYZ is a non-negative integer."
echo "If you are not sure, check https://www.dynare.org/release/source/ and pick the latest version."

echo -n "[Dynare version]: "
read dynare_version
file_name=dynare-$dynare_version.tar.xz

# Ask where MATLAB is installed
echo ""
echo "I need to know where your MATLAB installation is located."
echo "An example is '/usr/local/MATLAB/R2020b'"

echo -n "[Path to MATLAB]: "
read matlab_path

# Ask what MATLAB version is installed
echo ""
echo "I need to know what MATLAB version you have."
echo "To know which one it is, open MATLAB and run 'version', then pick the first two integers X.Y and type them here."

echo -n "[MATLAB version]: "
read matlab_version

echo ""
echo "Downloading Dynare source for version $dynare_version..."

# Download and unpack the relevant tarball
wget --quiet --show-progress https://www.dynare.org/release/source/$file_name
mkdir $install_dir/$dynare_version/ -p
tar xf ./$file_name --directory=$install_dir/$dynare_version
cd $install_dir/$dynare_version
mv ./dynare-$dynare_version/* ./
rm ./dynare-$dynare_version -rf

echo ""
echo "Dynare $dynare_version successfully downloaded and unpacked."
echo "I will proceed to configure the unpacked folder in 5 seconds".
echo "There will be a lot of lines printed, which say what is available and what not."
echo ""

# Configure build
sleep 5s
./configure --disable-octave --with-matlab=$matlab_path MATLAB_VERSION=$matlab_version CFLAGS="-O3" CXXFLAGS="-O3" MATLAB_MEX_CFLAGS="-O3" MATLAB_MEX_CXXFLAGS="-O3"

echo ""
echo "Configuration is over. Feel free to check the lines above to verify that all is good."
echo ""
echo "I will proceed to compile the source code into the binaries in 5 seconds."
echo "There will be a lot of lines printed, mostly related to C/C++ deprecation warnings."
echo "If all goes well, you can safely ignore those lines."
echo ""

# Compile source into binaries
sleep 5s
make

echo ""
echo "Compilation of source code is done. Hopefully everything went well."
echo "I will now delete unnecessary files and give you back control."
echo ""

cd -

# Remove the downloaded tarball
rm ./$file_name

# Say goodbye
echo ""
echo "Done! Do not forget to run 'addpath(~/.dynare/$dynare_version/matlab)' in MATLAB to use Dynare."
echo ""
