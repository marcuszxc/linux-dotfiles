function update
    set -l error 0

    echo "==> [CachyOS] Starting System & AUR Update (paru)..."
    paru -Syu --noconfirm --sudoloop; or set error 1

    if test $error -eq 0; and command -v flatpak > /dev/null
        echo "==> [Flatpak] Updating packages..."
        flatpak update -y; or set error 1
    else if test $error -eq 0
        echo "--> Flatpak not found, skipping..."
    end

    if test $error -eq 0
        echo "==> SUCCESS: All systems are up to date."
    else
        echo "==> ERROR: Update failed. Poweroff aborted for safety."
    end

    return $error
end
