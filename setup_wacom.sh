#!/bin/bash

# Function to install a package if it's not already installed
install_if_needed() {
    if ! dpkg -s "$1" > /dev/null 2>&1; then
        sudo apt install -y "$1"
    fi
}

echo "Updating package list..."
sudo apt update

echo "Installing necessary packages..."
install_if_needed build-essential
install_if_needed linux-headers-$(uname -r)
install_if_needed git
install_if_needed autoconf
install_if_needed libtool
install_if_needed pkg-config
install_if_needed xserver-xorg-input-wacom
install_if_needed libwacom2
install_if_needed libwacom-bin

echo "Cloning input-wacom repository..."
if [ ! -d "input-wacom" ]; then
    git clone https://github.com/linuxwacom/input-wacom.git
else
    echo "input-wacom directory already exists. Skipping clone."
fi

cd input-wacom || exit

echo "Running autogen.sh..."
./autogen.sh

echo "Configuring build environment..."
./configure

echo "Compiling drivers..."
make

echo "Installing drivers..."
sudo make install

echo "Loading wacom module..."
sudo modprobe wacom

echo "Checking for GPU drivers..."

# Suggest GPU driver installation based on the detected GPU
gpu=$(lspci | grep -i 'vga\|3d\|2d')
if echo "$gpu" | grep -i nvidia; then
    echo "NVIDIA GPU detected. Installing NVIDIA drivers..."
    install_if_needed nvidia-driver-460
elif echo "$gpu" | grep -i amd; then
    echo "AMD GPU detected. Installing AMD drivers..."
    install_if_needed xserver-xorg-video-amdgpu
elif echo "$gpu" | grep -i intel; then
    echo "Intel GPU detected. Installing Intel drivers..."
    install_if_needed xserver-xorg-video-intel
else
    echo "No recognized GPU detected. Skipping GPU driver installation."
fi

echo "Creating configuration script for Wacom One pen display..."

# Create configuration script
cat <<EOF > ~/configure_wacom.sh
#!/bin/bash

# Set your tablet's device names here
STYLUS="Wacom One pen display 11.6\" Pen stylus"
ERASER="Wacom One pen display 11.6\" Pen eraser"

# Set the stylus button functions
xsetwacom set "\$STYLUS" Button 2 3
xsetwacom set "\$STYLUS" Button 3 2

# Set the eraser button function
xsetwacom set "\$ERASER" Button 2 3

# Map the tablet to a specific monitor (replace HDMI-0 with your monitor identifier)
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode HDMI-0 "1920x1080_60.00"
xrandr --output HDMI-0 --mode "1920x1080_60.00" --right-of DP-0

echo "Wacom One pen display configuration applied."
EOF

chmod +x ~/configure_wacom.sh

echo "Adding configuration script to startup applications..."

# Create a desktop entry for autostart
mkdir -p ~/.config/autostart
cat <<EOF > ~/.config/autostart/configure_wacom.desktop
[Desktop Entry]
Type=Application
Exec=/home/$USER/configure_wacom.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Configure Wacom
Name=Configure Wacom
Comment[en_US]=Configure Wacom tablet settings
Comment=Configure Wacom tablet settings
EOF

echo "Installation and configuration complete. Please reboot your system."
