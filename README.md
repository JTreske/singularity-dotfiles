# ✨ Singularity Dotfiles

A fully featured desktop environment based on the dynamic tiling wayland compositor [**Hyprland**](https://github.com/hyprwm/hyprland).
This dotfiles repository is based on the [**Noctalia Shell**](https://github.com/noctalia-dev/noctalia-shell) and supports Hyprland config customization with the [ML4W Settings App](https://github.com/mylinuxforwork/ml4w-dotfiles-settings).

---

## 🛠 Installation

This dotfiles repository currently supports Arch Linux and Arch-based distributions like CachyOS.
A minimal installation of the selected distribution is needed to get started.

Run the following command and follow the instructions:

```bash
bash <(curl -s https://raw.githubusercontent.com/JTreske/singularity-dotfiles/refs/heads/main/install.sh)
```

Choose the `stable` release for the latest tagged version or the `rolling` release to install the current state of the `main` branch
The script uses [Singularity Dotfiles Manager]() to perform the installation.
This allows for multiple dotfile profiles to be installed and updated.

After installation of the dotfiles you have to reboot your system.\
You should boot into SDDM login screen.
If not enable the SDDM service, most likely by running the following command:

```bash
sudo systemctl enable --now sddm
```

### Curated App List

The Singularity Dotfiles Repository comes with a curated list of apps.
You can select the apps you need from this list.\
The installer will ask you if you want to install apps from this list or not.
If you wish to come back to this list later run one of the following commands:

```bash
# works with any dotfiles repository using the singularity-dotfiles-manager
singularity-dotfiles-manager apps

# or
singularity --apps
```

### Updating

You can just click on the updates icon in the top bar to start the [update script](dotfiles/.config/singularity/system-upgrade.sh).

If you wish to manually update:

- Make sure the system packages are up-to-date
- Run the installer again:
  ```bash
  bash <(curl -s https://raw.githubusercontent.com/JTreske/singularity-dotfiles/refs/heads/main/install.sh) --install
  ```

---

## ⚙️ Customization

> [!IMPORTANT]
> Singularity Dotfiles are highly customizable but make sure that you select your customized files for restore when updating the dotfiles.

### Customize Hyprland

This dotfiles repository supports the use of the [ML4W Settings App](https://github.com/mylinuxforwork/ml4w-dotfiles-settings) for customization of the Hyprland configuration.
You can configure Hyprland in small parts, like the keyboard layout, keybindings, or workspaces.

Run the settings app in the terminal with this command:

```bash
settings
```

or open the Quickshell GUI app with this command:

```bash
settings-gui
```

You may also manually edit the `~/.config/hypr/conf/custom.conf` (not supported by the settings app).
This can be useful if you only want to add a single keybinding or similar to the default configs.

### Customize Noctalia

Noctalia Shell provides a settings app for theming, installing plugins, and customization of the bar, the launcher, and more.
Find the settings app by clicking on the right most icon in the default top bar.

### ZSH

If you want to customize ZSH it would be best to only change the provided `.zshenv` file and set `ZDOTDIR` to another directory.
This way you only have to select `.zshenv` for restore.

### SDDM

Run the following command to enable the Singularity SDDM theme (based on SDDM silent) or set it in the initial install process:

```bash
singularity --theme
```

If you have a multi monitor setup you can turn off additional monitors by adding the following to `/usr/share/sddm/scripts/Xsetup`:

```bash
xrandr --output "<display-name>" --off
```

Find out the display names with the command `xrandr` (e.g., `DP-2`).

You might also want to change the content of `/usr/share/icons/default/index.theme` to the following to have the same cursor as everywhere else:

```ini
[Icon Theme]
Inherits=Bibata-Modern-Ice
```

---

## 📚 Documentation

- [**Singularity Dotfiles Manager**]()
- [**Hyprland**](https://wiki.hypr.land/)
- [**Noctalia Shell**](https://noctalia.dev/)

---

## 📜 License

Distributed under the GPLv3 License. See [LICENSE](LICENSE.md) for more information.
