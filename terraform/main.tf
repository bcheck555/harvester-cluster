# Terraform resources 

# Rancher cloud credentials
data "rancher2_cloud_credential" "cloud_credential" {
  name = var.RANCHER_CLOUD_CREDENTIAL
}

# Create a new rancher2 machine config v2 using harvester node_driver
resource "rancher2_machine_config_v2" "cn" {
  generate_name = "cn-config"
  harvester_config {
    vm_namespace = "default"
    cpu_count = var.CN_CPUCOUNT
    memory_size = var.CN_MEMORY
    disk_info = <<EOF
    {
        "disks": [{
          "imageName": "default/image-stv28",
          "size": 40,
          "bootOrder": 1
        }]
    }
    EOF
    network_info = <<EOF
    {
        "interfaces": [{
          "networkName": "default/vlan20"
        }]
    }
    EOF
    ssh_user = "ubuntu"
    user_data = <<EOF
    #cloud-config
    disable_root: false
    chpasswd:
    list: |
        root:password
    expire: false
    package_update: true
    packages:
    - qemu-guest-agent
    runcmd:
    - systemctl enable --now qemu-guest-agent
    EOF
  }
}

resource "rancher2_machine_config_v2" "wn" {
  generate_name = "wn-config"
  harvester_config {
    vm_namespace = "default"
    cpu_count = var.WN_CPUCOUNT
    memory_size = var.WN_MEMORY
    disk_info = <<EOF
    {
        "disks": [{
          "imageName": "default/image-stv28",
          "size": 100,
          "bootOrder": 1
        }]
    }
    EOF
    network_info = <<EOF
    {
        "interfaces": [{
            "networkName": "default/vlan20"
        }]
    }
    EOF
    ssh_user = "ubuntu"
    user_data = <<EOF
    #cloud-config
    disable_root: false
    chpasswd:
    list: |
        root:password
    expire: false
    package_update: true
    packages:
    - qemu-guest-agent
    runcmd:
    - systemctl enable --now qemu-guest-agent
    EOF
  }
}

# Create a new harvester rke2 cluster with harvester cloud provider
resource "rancher2_cluster_v2" "cluster" {
  name = var.CLUSTER_NAME
  kubernetes_version = var.RKE2VERSION
  enable_network_policy = false
  default_cluster_role_for_project_members = "user"
  rke_config {
    machine_pools {
      name = "pool1"
      cloud_credential_secret_name = data.rancher2_cloud_credential.cloud_credential.id
      control_plane_role = true
      etcd_role = true
      worker_role = false
      quantity = var.CN_NUMNODES
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.cn.kind
        name = rancher2_machine_config_v2.cn.name
      }
    }
    # Each machine pool must be passed separately
    machine_pools {
      name = "pool2"
      cloud_credential_secret_name = data.rancher2_cloud_credential.cloud_credential.id
      control_plane_role = false
      etcd_role = false
      worker_role = true
      quantity = var.WN_NUMNODES
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.wn.kind
        name = rancher2_machine_config_v2.wn.name
      }
    }    
    machine_selector_config {
      config = <<EOF
        kubelet-arg:
          - cloud-provider-config = file("${path.module}/kubeconfig")
          - cloud-provider-name = harvester
    EOF
    }
    machine_global_config = <<EOF
cni: "calico"
disable-kube-proxy: false
etcd-expose-metrics: false
EOF
    upgrade_strategy {
      control_plane_concurrency = "10%"
      worker_concurrency = "10%"
    }
    etcd {
      snapshot_schedule_cron = "0 */5 * * *"
      snapshot_retention = 5
    }
    chart_values = <<EOF
harvester-cloud-provider:
  clusterName: var.CLUSTER_NAME
  cloudConfigPath: /var/lib/rancher/rke2/etc/config-files/cloud-provider-config
EOF
  }
}