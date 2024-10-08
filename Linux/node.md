<!-- TOC -->
* [Installation Instructions](#installation-instructions)
<!-- TOC -->

# [Installation Instructions ](https://github.com/nodesource/distributions/blob/master/README.md)

Before you begin, ensure that `curl` is installed on your system. If `curl` is not installed, you can install it using the following command:

`sudo apt-get install -y curl`

Download the setup script:

`curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh`

Run the setup script with sudo:

`sudo -E bash nodesource_setup.sh`

Install Node.js:

`sudo apt-get install -y nodejs`

Verify the installation:

`node -v`
