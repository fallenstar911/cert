terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

variable "cores" {}
variable "memory" {}
variable "disksize" {}

provider "yandex" {
  token     = "AQAAAAAW0L3nAATuweWz_tJfpkd9uc1Nt3QSXtc"
  cloud_id  = "b1gum8fcved4h6kt3fr1"
  folder_id = "b1gtmnl9j48rhmjbbmjc"
  zone      = "ru-central1-b"
}

  resource "yandex_compute_instance" "vm-1" {
    name = "terraform1"

    resources {
      cores  = var.cores
      memory = var.memory
    }


    boot_disk {
      initialize_params {
        image_id = "fd82re2tpfl4chaupeuf"
        size = var.disksize
      }
    }

    network_interface {
      subnet_id = yandex_vpc_subnet.subnet-1.id
      nat       = true
    }

    metadata = {
      ssh-keys = "pavel:${file("~/.ssh/id_rsa.pub")}"
    }
  }

  resource "yandex_compute_instance" "vm-2" {
    name = "terraform2"

    resources {
      cores  = var.cores
      memory = var.memory
    }

    boot_disk {
      initialize_params {
        image_id = "fd82re2tpfl4chaupeuf"
        size = var.disksize
      }
    }

    network_interface {
      subnet_id = yandex_vpc_subnet.subnet-1.id
      nat       = true
    }

    metadata = {
      ssh-keys = "pavel:${file("~/.ssh/id_rsa.pub")}"
    }
  }


  resource "yandex_compute_instance" "vm-3" {
    name = "terraform3"

    resources {
      cores  = var.cores
      memory = var.memory
    }

    boot_disk {
      initialize_params {
        image_id = "fd82re2tpfl4chaupeuf"
        size = var.disksize
      }
    }

    network_interface {
      subnet_id = yandex_vpc_subnet.subnet-1.id
      nat       = true
    }

    metadata = {
      ssh-keys = "pavel:${file("~/.ssh/id_rsa.pub")}"
    }
  }



  resource "yandex_vpc_network" "network-1" {
    name = "network1"
  }

  resource "yandex_vpc_subnet" "subnet-1" {
    name           = "subnet1"
    zone           = "ru-central1-b"
    network_id     = yandex_vpc_network.network-1.id
    v4_cidr_blocks = ["10.55.26.0/24"]
  }

  output "internal_ip_address_vm_1" {
    value = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }

  output "internal_ip_address_vm_2" {
    value = yandex_compute_instance.vm-2.network_interface.0.ip_address
  }

  output "internal_ip_address_vm_3" {
    value = yandex_compute_instance.vm-3.network_interface.0.ip_address
  }


  output "external_ip_address_vm_1" {
    value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
  }

  output "external_ip_address_vm_2" {
    value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
  }

  output "external_ip_address_vm_3" {
    value = yandex_compute_instance.vm-3.network_interface.0.nat_ip_address
  }