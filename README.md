# flatpak-menu-sync

A simple script to sync flatpak menu entries to dmenu.

## Use case

This script is useful for users who want to use flatpak and dmenu apps like `rofi` or `fuzzel`.
Once a flatpak app is installed, it will automatically appear in dmenu (while keeping the traditional applications).

## Configuration

You have to modify the `flatpak-menu-sync.service.example` file to your needs, then rename it to `flatpak-menu-sync.service`.
For most users, the default miniconda3 path should be in `/home/yourusername/miniconda3/` and thus the example file should be fine.
Remember to set your username in the `ExecStart` line.

## Troubleshooting

If the service doesn't start, check the logs with `journalctl -u flatpak-menu-sync.service`.

### Error: "flatpak-menu-sync.service not found"

This error occurs if the service file was not renamed to `flatpak-menu-sync.service`. Please see the previous section for more information.

### Errors related to the `pyinotify` packages

Please install the `pyinotify` package through your package manager.
Pip should be supported but if it doesn't work, please try:

#### Ubuntu/Debian

```bash
sudo apt install python3-pyinotify
```

#### Arch Linux

```bash
sudo pacman -S python-pyinotify
```

#### Fedora

```bash
sudo dnf install python3-pyinotify
```

And restart the service with `sudo systemctl restart flatpak-menu-sync.service`.

## Installation

Once you have cloned the repository and followed the configuration section, you can run the `integrate.sh` script to install the service.

```bash
./integrate.sh
```

If you prefer, you can manually execute the script with the correct user and miniconda path.

## License

This project is licensed under the Do What The Fuck You Want To Public License. See the [LICENSE.md](LICENSE.md) file for details.
