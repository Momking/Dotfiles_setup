# Dotfiles

Personal Linux desktop configuration built around **Niri**.

## Included Configurations

```text
.config/
├── eww/                     # Widgets
├── hexecute/                # Application launcher configuration
├── hypr/                    # Hyprlock / Hyprpaper configuration
├── linux-desktop-gremlin/   # Desktop gremlin
├── matugen/                 # Dynamic color generation
├── niri/                    # Niri compositor configuration
├── nvim/                    # Neovim configuration
├── Wallpaper/               # Wallpapers
├── waybar/                  # Status bar and sidebar
├── wlogout/                 # Logout / power menu
├── wofi/                    # Launcher and custom menus
└── zed/                     # Zed editor configuration
```

## Setup

Clone the repository:

```bash
git clone https://github.com/Momking/Dotfiles_setup.git ~/dotfiles
```

Copy the configurations:

```bash
cp -r ~/dotfiles/.config/* ~/.config/
```

Or use only the configurations you need:

```bash
cp -r ~/dotfiles/.config/niri ~/.config/
cp -r ~/dotfiles/.config/waybar ~/.config/
cp -r ~/dotfiles/.config/wofi ~/.config/
```

## Configuration Integration

The setup is centered around Niri:

```text
Niri
├── Waybar
├── Wofi
├── Hexecute
├── Eww
├── Hypr
│   ├── Hyprlock
│   └── Hyprpaper
└── Linux Desktop Gremlin

Matugen
├── Dynamic colors
└── Wallpaper-based theming

Editors
├── Neovim
└── Zed
```

## Main Keybindings

| Keybinding | Action |
|---|---|
| `Mod + T` | Open terminal |
| `Mod + D` | Open Wofi |
| `Mod + Space` | Open Hexecute |
| `Super + Alt + L` | Lock screen |
| `Mod + M` | Toggle Waybar sidebar |
| `Mod + Ctrl + Shift + P` | Open Gremlin changer |
| `Print` | Screenshot |
| `Ctrl + Print` | Screenshot screen |
| `Alt + Print` | Screenshot window |

## Usage

### Niri

The main compositor configuration is located at:

```text
~/.config/niri/config.kdl
```
It contains the keybindings and other configuration for waybar, wofi, and other utilities.

### Waybar

```bash
waybar
```

Toggle the custom sidebar with:

```text
Mod + M
```

### Wofi

```bash
wofi --show drun
```

Custom menus are available for wallpapers, files, calculator, and the desktop gremlin.

### Hexecute

Open with:

```text
Mod + Space
```

### Eww

```bash
eww daemon
```

### Wlogout

```bash
wlogout
```

### Matugen

Used for wallpaper-based dynamic color generation.

### Linux Desktop Gremlin

Integrated with the desktop through the included scripts and Niri keybindings.

### Neovim

```bash
nvim
```

### Zed

The repository includes Zed settings and custom themes.

## Notes

Some configuration files may contain machine-specific paths. Update them before use.

Configurations are connected to the Niri compositor and may require adjustments for your setup.

Use your own discretion when using configurations.
