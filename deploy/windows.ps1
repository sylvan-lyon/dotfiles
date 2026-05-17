Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# -------- Paths --------

$DotfilesRoot = Split-Path -Parent $PSScriptRoot

$XDG_CONFIG_HOME = "$HOME\.config"
$XDG_DATA_HOME   = "$HOME\.local\share"
$XDG_CACHE_HOME  = "$HOME\.cache"

# -------- Helpers --------

function Ensure-Directory {
  param([string]$Path)

  if (-not (Test-Path $Path)) {
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
  }
}

function Remove-If-Exists {
  param([string]$Path)

  if (Test-Path $Path) {
    Remove-Item $Path -Recurse -Force
  }
}

function Ensure-Symlink {
  param(
    [string]$Link,
    [string]$Target
  )

  Remove-If-Exists $Link
  New-Item -ItemType SymbolicLink -Path $Link -Target $Target | Out-Null
}

# -------- Declarative Mapping --------
# 每一项：repo → XDG → program path

$Configs = @(
  @{
    Name   = "bat"
    Source = "$DotfilesRoot\config\bat\.config\bat"
    Xdg    = "$XDG_CONFIG_HOME\bat"
    Target = "$env:APPDATA\bat"
  },
  @{
    Name   = "btop"
    Source = "$DotfilesRoot\config\btop\.config\btop"
    Xdg    = "$XDG_CONFIG_HOME\btop"
    Target = "$env:APPDATA\btop"
  },
  @{
    Name   = "fastfetch"
    Source = "$DotfilesRoot\config\fastfetch\.config\fastfetch"
    Xdg    = "$XDG_CONFIG_HOME\fastfetch"
    Target = "$env:APPDATA\fastfetch"
  },
  @{
    Name   = "ghostty"
    Source = "$DotfilesRoot\config\ghostty\.config\ghostty"
    Xdg    = "$XDG_CONFIG_HOME\ghostty"
    Target = "$env:APPDATA\ghostty"
  },
  @{
    Name   = "nushell"
    Source = "$DotfilesRoot\config\nushell\.config\nushell"
    Xdg    = "$XDG_CONFIG_HOME\nushell"
    Target = "$env:APPDATA\nushell"
  },
  @{
    Name   = "nvim"
    Source = "$DotfilesRoot\config\nvim\.config\nvim"
    Xdg    = "$XDG_CONFIG_HOME\nvim"
    Target = "$env:LOCALAPPDATA\nvim"
  },
  @{
    Name   = "starship"
    Source = "$DotfilesRoot\config\starship\.config\starship.toml"
    Xdg    = "$XDG_CONFIG_HOME\starship.toml"
    Target = "$XDG_CONFIG_HOME\starship.toml"
  },
  @{
    Name   = "tealdeer"
    Source = "$DotfilesRoot\config\tealdeer\.config\tealdeer"
    Xdg    = "$XDG_CONFIG_HOME\tealdeer"
    Target = "$env:APPDATA\tealdeer"
  },
  @{
    Name   = "wezterm"
    Source = "$DotfilesRoot\config\wezterm\.config\wezterm"
    Xdg    = "$XDG_CONFIG_HOME\wezterm"
    Target = "$XDG_CONFIG_HOME\wezterm"
  },
  @{
    Name   = "yazi"
    Source = "$DotfilesRoot\config\yazi\.config\yazi"
    Xdg    = "$XDG_CONFIG_HOME\yazi"
    Target = "$env:APPDATA\yazi\config"
  }
)

# -------- Deploy --------

Write-Host "Deploying dotfiles..." -ForegroundColor Cyan

foreach ($cfg in $Configs) {
  Write-Host "→ $($cfg.Name)" -ForegroundColor Green

  # repo → XDG
  Ensure-Directory (Split-Path $cfg.Xdg)
  Ensure-Symlink  $cfg.Xdg $cfg.Source

  # XDG → program
  Ensure-Directory (Split-Path $cfg.Target)
  Ensure-Symlink  $cfg.Target $cfg.Source
}

Write-Host "`nAll dotfiles deployed successfully." -ForegroundColor Cyan
