#!/usr/bin/env bash

set -e

check_pass() {
    local prompt="$1"
    local var_name="$2"

    while true; do
        read -s -e -p "$prompt" password1 && echo ""
        read -s -e -p "Verify $prompt" password2 && echo ""

        if [ "$password1" = "$password2" ]; then
            eval "$var_name=\"$password1\""
            break
        else
            echo "Entries don't match. Please try again."
        fi
    done
}

read -e -p "Username: " USERNAME
check_pass "Userpass: " USERPASS
read -e -p "SSH key: " KEY_NAME
check_pass "SSH Passphrase: " PASSPHRASE

if ! command -v sudo &>/dev/null; then
    pacman -Sy sudo --noconfirm || {
        exit 1
    }
else
    echo "sudo already exists"
fi

echo "Download and execute the sudouser script"
curl -fLO "https://raw.githubusercontent.com/odeysseuss/.dotfiles/refs/heads/master/scripts/startup/sudouser.sh"
chmod 700 sudouser.sh
./sudouser.sh $USERNAME $USERPASS

echo "System Update..."
pacman -Syu --needed --noconfirm || {
    echo "Failed to update system and install packages"
    exit 1
}

echo "Execute the setup script as the $USERNAME user"
su - $USERNAME -c "curl -fsSL 'https://raw.githubusercontent.com/odeysseuss/.dotfiles/refs/heads/master/scripts/startup/setup.sh' | sh -s -- $USERNAME $KEY_NAME $PASSPHRASE"

echo "su - $USERNAME" >>~/.bash_profile
