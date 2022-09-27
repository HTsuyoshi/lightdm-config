#!/bin/bash

PKG_MNG='paru'
SUDO='doas'

echo 'Downloading lightdm and web-greeter...'
$PKG_MNG -S lightdm web-greeter || exit 1

echo 'Enabling lightdm.service...'
$SUDO systemctl enable lightdm.service || exit 1

echo 'Setting greeter-session...'
$SUDO sed -i '102s/# greeter-session/greeter-session=web-greeter/' /etc/lightdm/lightdm.conf || exit 1

echo 'Copying user icon...'
$SUDO cp icon /var/lib/AccountsService/icons/$USER || exit 1

echo 'Setting user icon...'
$SUDO echo "Icon=/var/lib/AccountsService/icons/$USER" >> /var/lib/AccountsService/users/$USER || exit 1
