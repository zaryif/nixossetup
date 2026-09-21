# NixOS System Configuration
# Maintainer: Zaryif
# Repository: nixossetup

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Experimental Features (Nix Flakes & Nix Command)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Hardware Graphics & AMDGPU Driver Upgrade
  boot.kernelParams = [ 
    "radeon.cik_support=0" 
    "amdgpu.cik_support=1" 
    "radeon.si_support=0" 
    "amdgpu.si_support=1" 
  ];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ 
      intel-media-driver 
      intel-vaapi-driver 
      libva-vdpau-driver 
      libvdpau-va-gl 
      mesa 
    ];
  };

  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname & Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone & Regional Locales
  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "bn_BD";
    LC_IDENTIFICATION = "bn_BD";
    LC_MEASUREMENT = "bn_BD";
    LC_MONETARY = "bn_BD";
    LC_NAME = "bn_BD";
    LC_NUMERIC = "bn_BD";
    LC_PAPER = "bn_BD";
    LC_TELEPHONE = "bn_BD";
    LC_TIME = "bn_BD";
  };

  # Security & Permissions
  services.udev.extraRules = ''KERNEL=="uinput", MODE="0666"'';
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  # Display & Desktop Environment (GNOME on Wayland/X11)
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Keyboard Layout & Key Bindings
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:swap_lwin_lctl";
  };

  # Sound & Multimedia Services (Pipewire)
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User Account Configuration
  users.users."zaryif" = {
    isNormalUser = true;
    description = "zaryif";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Programs & Unfree Software
  programs.firefox.enable = true;
  programs.ydotool.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Wayland Environment Variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # System Profile Packages
  environment.systemPackages = with pkgs; [
    # Core utilities
    git
    vim
    wget
    curl
    nodejs_22

    # Desktop & Productivity
    chromium
    obsidian

    # Python & Automation Ecosystem
    (python3.withPackages (ps: with ps; [ 
      pyautogui 
      pillow 
      mss 
      pip 
      evdev 
      playwright 
    ]))
    playwright-driver

    # Graphics & Screenshot tools
    scrot
    wmctrl
    ffmpeg
    xwd
    grim
    slurp
    imagemagick
    gnome-screenshot
    xdotool
    ydotool
  ];

  # NixOS Release State Version
  system.stateVersion = "26.05";
}
