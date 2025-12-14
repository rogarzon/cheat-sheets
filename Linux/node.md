<!-- TOC -->
* [Installation Instructions](#installation-instructions)
* [Download Node.js® using `nvm` (Node Version Manager):](#download-nodejs-using-nvm-node-version-manager)
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

# Download Node.js® using `nvm` (Node Version Manager):
```bash
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 24

# Verify the Node.js version:
node -v # Should print "v24.12.0".

# Verify npm version:
npm -v # Should print "11.6.2".

```