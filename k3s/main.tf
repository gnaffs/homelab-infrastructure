provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url      = "https://proxmox:8006/api2/json"
  pm_user         = "terraform-user@pve"
}

module "k3s-cluster" {
  source = "../tf-modules/generic-cluster"

  name_prefix = "k3s"

  # ssh_user = "k3s"

  ips = [
    "10.2.0.30",
    "10.2.0.31",
    "10.2.0.32",
  ]
  macs = [
    "DA:42:E5:28:86:7C",
    "BA:5B:64:97:59:8F",
    "52:7F:22:E5:1F:1F",
  ]
  nodes = [
    "proxmox",
    "proxmox-b",
    "proxmox-c",
  ]
  sshkeys      = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZwZQdLmDKglLw9NYz1SN7+55wTNqCeU2lJN6HQgJ2vyUrpD4T6JcduiH/0aUoUz9vVhfqphwT0hH3O+q/+L1pkCUibiqh4cS9kB46aV5AX5kovcECGa5zaWlGHBepVqitI0J+nmAEQJhsPefaRDLWjJ4CNKODsbtfj+jBNhI9OzMEqR7EDqYu8h6N1KCtqIujxZ/DeumxYsf9ERnjSnRdfekImv9hVojPkDFAj1E3MLfhEfAj6wzZw4bbrqOrssE5K6aK03QEjAULVro2FgAKodFNO8awp0fPb71dzjB2DTlinCYaHSorkwk6w1XJxCMt8jO3nrTth/3+4HzBdaP5 root@proxmox
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMqgYe/v1r9WHIydNgas3hlXYpdHgPy04ZEYVoZirYpZD/tUuZ5XYzn4LkatRu/lD6YOKISMxRGSV0fEXqFjOQ2Tk+NlgkSOawy/0ED5X/LvI1Sqs39ilFeerKAK0H+ZJfOZzRjlG98QF+0/OFShsHK9JdwmLAH4+wPOzxpwkkXtyVj0mzuFuz84Wpp1uYRpBFp7FRK5pf2wOaZgzu8rdh/zaS3E2vZVYm6gtJuKVfceT0K+IbPdAazKljT9m0xYsXnP0JQCCuxW6GTmVI0dmFSa+VGg0anjUAU0gnm9A9mcOU1NfxigPiEaKjMMFUxtwJQGm8+iYraVsnySzzRQfn jeff@hackintosh.local
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6YYaZvxevdnjTE2Ac5LzgYOXXoVUYX78kPcH2ENMtoiw+438cnlSidYHlC0mMzhmeDAuTS7znpbvgzxknPxTJFOyQnticuzMo2hOTl3xnDMNd1bk38gewm88getY03z2ZymyGfOe/zmJdNZW6SP53c1EHIjiAcb1Cd64FZzpUeiBKQ0dm4D01xFxinnLjU4BmOCKMbN7NSbuAaQtlfaxv9nb/2hjNau5B3kewKFEB3douTCO4VlIIDIq9KXQUUE+aJ/fWTPYB9ymqzahjaRe3e4e1U72J6UB3rxKf3y+R6Y/mj+rYloWGvig2pPJRqCLmNMeeObzwiisPPJCbQ3g5 jeff@andor
EOF
  gateway      = "10.2.0.1"
  vlanid       = "20"
  bridge       = "vmbr0"
  storage_size = "64G"
  storage_pool = "proxmox"
  storage_type = "raw"
  memory       = "8192"
  # storage_size2 = "500G"
  # storage_pool2 = "proxmox"
  # storage_type2 = "raw"
  # target_node  = "proxmox"
}
