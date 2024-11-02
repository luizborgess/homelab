terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
      cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
  backend "s3" {}
  
}

provider "proxmox" {
  pm_api_url  = "https://procyon.hlspace.org:8006/api2/json"
  pm_user     = var.pm_user
  pm_password = var.pm_password
}