# ❄️ Zaryif's NixOS Setup (`nixossetup`)

[![NixOS](https://img.shields.io/badge/NixOS-26.05-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![Nix Flakes](https://img.shields.io/badge/Nix_Flakes-Enabled-blueviolet?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![Desktop](https://img.shields.io/badge/Desktop-GNOME_Wayland-4A154B?style=for-the-badge&logo=gnome&logoColor=white)](https://www.gnome.org/)
[![Antigravity CLI](https://img.shields.io/badge/AI_Engine-Antigravity_YOLO_Mode-00C7B7?style=for-the-badge&logo=google&logoColor=white)](https://github.com/Hy4ri/antigravity-flake)

> A modern, robust, and reproducible NixOS system configuration powered by **Nix Flakes**, tuned for graphics acceleration, web automation, Python development, and **Antigravity CLI in Full Autonomy (YOLO) Mode**.

---

## 🚀 Key Features & Stack Overview

- **Nix Flakes Native**: Fully declarative system state backed by `flake.nix` and `flake.lock` for 100% reproducible builds anywhere.
- **Antigravity CLI & YOLO Mode Engine**: 
  - Integrated via `antigravity-flake` input (`antigravity` & `antigravity-cli`).
  - Pre-configured for **Full Autonomy (YOLO Mode)**: no manual confirmation prompts, direct system command execution, self-correction, spatial UI clicking engine, and auto-granting UI dialog permissions.
- **Desktop & Display**: GNOME Desktop Environment on **Wayland** (`NIXOS_OZONE_WL=1`) with customized keyboard mapping (`ctrl:swap_lwin_lctl` option).
- **Hardware Acceleration**: 
  - **AMD GPU Support**: Kernel parameters configured for CIK/SI support (`amdgpu.cik_support=1`).
  - **VA-API & Media Acceleration**: Intel media drivers, VAAPI/VDPAU wrappers, and Mesa driver stack.
- **Development & Automation Toolkit**:
  - **Node.js 22**, **Git**, **Vim**, **Curl**, **Wget**
  - **Python 3 Environment**: Loaded with `pyautogui`, `pillow`, `mss`, `evdev`, `playwright`, and `playwright-driver`.
  - **Browsers & Utilities**: Firefox, Chromium, Obsidian, `ffmpeg`, `scrot`, `grim`, `slurp`, `xdotool`, `ydotool`, and `imagemagick`.
- **Modern Audio Stack**: **PipeWire** sound server with ALSA 32-bit support, PulseAudio emulation, and RTKit priority scheduling.

---

## 🤖 Antigravity CLI & YOLO Mode Architecture

The Antigravity CLI setup on this system operates in **Full Autonomy (YOLO Mode)**, allowing the agentic AI to inspect, edit, build, automate, and control system software and spatial UI interfaces without friction.

### 1. System-Level Privileges & OS Tuning (`configuration.nix`)
To enable uninterrupted background execution and hardware control for Antigravity CLI:
- **Passwordless Sudo**: `security.sudo.wheelNeedsPassword = false` — Allows AGY CLI to perform privileged package installs and nix rebuilds without getting blocked by password prompts.
- **Kernel Input Access**: `services.udev.extraRules = ''KERNEL=="uinput", MODE="0666"'';` — Provides unprivileged access to `/dev/uinput` for hardware-level keyboard & mouse input control (`evdev` / `ydotool`).
- **Input Automation Daemon**: `programs.ydotool.enable = true` — System service for simulated user inputs.
- **Wayland Ozone Compatibility**: `NIXOS_OZONE_WL = "1"` — Enables native Wayland rendering for Chromium and AI desktop tools.

### 2. Antigravity Agent Rules & Permissions (`antigravity-config/`)
- **`settings.json`**: Configures `"toolPermission": "always-proceed"`, `"artifactReviewPolicy": "always-proceed"`, and enables the Chrome DevTools MCP server (`chrome-devtools-mcp`).
- **`rules/autonomy.md`**: Enforces strict non-interactive execution (never ask "Should I proceed?", direct tool execution, automated issue self-correction).
- **`rules/identity.md`**: Defines identity & `--dangerously-skip-permissions` execution policy.
- **`rules/clicky_capabilities.md`**: Autonomous desktop authority to automatically click and approve GNOME dialogs, permission popups, or confirmation windows ("Allow", "Share", "Confirm", "Yes").
- **`GEMINI.md`**: Spatial UI map & spatial pointing guidelines.

---

## 📂 Repository Structure

```authority
nixossetup/
├── flake.nix                  # Flake entrypoint defining inputs & nixosConfigurations
├── flake.lock                 # Immutable lockfile pinning dependency versions
├── configuration.nix          # Main declarative system configuration & package lists
├── hardware-configuration.nix # System hardware scan & file systems layout
├── antigravity-config/        # Antigravity CLI YOLO Mode configs & rules template
│   ├── settings.json          # Antigravity settings ("always-proceed", MCP servers)
│   ├── GEMINI.md              # Global AGY desktop authorization rules
│   ├── rules/                 # Autonomy, identity & spatial automation rules
│   │   ├── autonomy.md
│   │   ├── identity.md
│   │   └── clicky_capabilities.md
│   └── setup-antigravity.sh   # Installer script to sync rules to ~/.gemini/antigravity-cli/
├── .gitignore                 # Files excluded from Git tracking
└── README.md                  # Detailed documentation & setup instructions
```

---

## ⚡ Quickstart & Usage Instructions

### 1. Cloning the Repository
Clone this repository to your target machine:

```bash
git clone https://github.com/zaryif/nixossetup.git ~/nixos
cd ~/nixos
```

---

### 2. Applying System Configuration

To apply this configuration to your running NixOS machine:

```bash
# Rebuild and activate NixOS system
sudo nixos-rebuild switch --flake .#nixos
```

---

### 3. Deploying Antigravity CLI YOLO Mode Configs

To initialize/sync the Antigravity CLI rules, YOLO permissions, and settings on a fresh machine:

```bash
cd ~/nixos
./antigravity-config/setup-antigravity.sh
```

---

### 4. Installing on a New Machine

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
6. Reboot into your new environment, clone this repo, and run `./antigravity-config/setup-antigravity.sh`! 🚀

---

## 🔄 System Maintenance & Updates

| Action | Command |
| :--- | :--- |
| **Rebuild System** | `sudo nixos-rebuild switch --flake .#nixos` |
| **Test Rebuild (no boot entry)** | `sudo nixos-rebuild test --flake .#nixos` |
| **Deploy AGY YOLO Mode** | `./antigravity-config/setup-antigravity.sh` |
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
