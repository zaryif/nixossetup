# ❄️ Zaryif's NixOS Setup (`nixossetup`)

[![NixOS](https://img.shields.io/badge/NixOS-26.05-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![Nix Flakes](https://img.shields.io/badge/Nix_Flakes-Enabled-blueviolet?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![Desktop](https://img.shields.io/badge/Desktop-GNOME_Wayland-4A154B?style=for-the-badge&logo=gnome&logoColor=white)](https://www.gnome.org/)
[![Antigravity](https://img.shields.io/badge/AI_Engine-Antigravity-00C7B7?style=for-the-badge&logo=google&logoColor=white)](https://github.com/Hy4ri/antigravity-flake)

> A modern, robust, and reproducible NixOS system configuration powered by **Nix Flakes**, tuned for graphics acceleration, web automation, Python development, and integrated AI tools.

---

## 🚀 Key Features & Stack Overview

- **Nix Flakes Native**: Fully declarative system state backed by `flake.nix` and `flake.lock` for 100% reproducible builds anywhere.
- **Desktop & Display**: GNOME Desktop Environment on **Wayland** (`NIXOS_OZONE_WL=1`) with customized keyboard mapping (`ctrl:swap_lwin_lctl` option).
- **Hardware Acceleration**: 
  - **AMD GPU Support**: Kernel parameters configured for CIK/SI support (`amdgpu.cik_support=1`).
  - **VA-API & Media Acceleration**: Intel media drivers, VAAPI/VDPAU wrappers, and Mesa driver stack.
- **AI & CLI Extensions**: Pre-configured with the **Antigravity** flake input (`antigravity` & `antigravity-cli`).
- **Development & Automation Toolkit**:
  - **Node.js 22**, **Git**, **Vim**, **Curl**, **Wget**
  - **Python 3 Environment**: Loaded with `pyautogui`, `pillow`, `mss`, `evdev`, `playwright`, and `playwright-driver`.
  - **Browsers & Utilities**: Firefox, Chromium, Obsidian, `ffmpeg`, `scrot`, `grim`, `slurp`, `xdotool`, `ydotool`, and `imagemagick`.
- **Modern Audio Stack**: **PipeWire** sound server with ALSA 32-bit support, PulseAudio emulation, and RTKit priority scheduling.

---

## 📂 Repository Structure

```authority
nixossetup/
├── flake.nix                  # Flake entrypoint defining inputs & nixosConfigurations
├── flake.lock                 # Immutable lockfile pinning dependency versions
├── configuration.nix          # Main declarative system configuration & package lists
├── hardware-configuration.nix # System hardware scan & file systems layout
├── .gitignore                 # Files excluded from Git tracking
└── README.md                  # Detailed documentation & setup instructions
```

---

## ⚡ Quickstart & Usage Instructions

### 1. Cloning the Repository
Clone this repository to your target machine (preferably into `~/nixos` or `/etc/nixos`):

```bash
git clone https://github.com/zaryif/nixossetup.git ~/nixos
cd ~/nixos
```

---

### 2. Applying Configuration to Current System

To apply this configuration to your running NixOS machine:

```bash
# Rebuild and activate configuration
sudo nixos-rebuild switch --flake .#nixos
```

Or if your repository is placed at `/etc/nixos`:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

---

### 3. Installing on a New Machine

1. **Perform standard NixOS partitioning & formatting** (Btrfs root + `/boot` vfat).
2. **Mount the file systems** to `/mnt`.
3. **Generate hardware scan** or adapt `hardware-configuration.nix`:
   ```bash
   nixos-generate-config --root /mnt
   ```
4. **Copy `flake.nix` and `configuration.nix`** into `/mnt/etc/nixos/`.
5. **Run NixOS Installation**:
   ```bash
   sudo nixos-install --flake /mnt/etc/nixos#nixos
   ```
6. Reboot into your new environment! 🚀

---

## 🔄 System Maintenance & Updates

| Action | Command |
| :--- | :--- |
| **Rebuild System** | `sudo nixos-rebuild switch --flake .#nixos` |
| **Test Rebuild (no boot entry)** | `sudo nixos-rebuild test --flake .#nixos` |
| **Update Flake Dependencies** | `nix flake update` |
| **Clean Old Generations** | `sudo nix-collect-garbage -d` |
| **Optimize Nix Store** | `nix-store --optimise` |

---

## 🛡️ Rollback Safety

If a rebuild introduces an issue, boot into a previous generation from the systemd-boot menu on startup, or roll back immediately with:

```bash
sudo nixos-rebuild switch --rollback
```

---

## 👤 Maintainer

Created & maintained by **Zaryif** ([@zaryif](https://github.com/zaryif)).
