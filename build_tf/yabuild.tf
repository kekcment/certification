terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "${file("/var/lib/jenkins/ya/agorbanev.json")}"
  cloud_id  = "b1g6n29jkok2srs36sqc"
  folder_id = "b1g6lkkjagvcniim0l5h"
  zone      = "ru-central1-b"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-1" {
  name = "vm-1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      type = "network-ssd"
      size = 20
    }
  }

  network_interface {
    subnet_id = "e2lvp1dpmlcm62r0r221"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/var/lib/jenkins/.ssh/build_key.pub")}"
  }
  
  scheduling_policy {
    preemptible = true
  }

}


# resource "yandex_compute_instance" "vm-2" {
#   name = "vm-2"

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = data.yandex_compute_image.ubuntu_image.id
#     #   type = "network-ssd"
#       size = 20
#     }
#   }

#   network_interface {
#     subnet_id = "e2lvp1dpmlcm62r0r221"
#     nat       = true
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${file("/var/lib/jenkins/.ssh/build_key.pub")}"
#   }

#     scheduling_policy {
#         preemptible = true
#   }
# }


# connection {
#     type = "ssh"
#     user = "ubuntu"
#     private_key = file("/var/lib/jenkins/.ssh/build_key")
#     host = self.network_interface[0].nat_ip_address
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update && sudo apt install python -y"
#     ]
#   }

# }

# provisioner "local-exec" {
#     command = "echo > /tmp/test1 && echo '[build]' > /tmp/test1 && echo ${self.network_interface[0].nat_ip_address} >> /tmp/test1"
#   }