# Terraform resources 

# Rancher cloud credentials
data "rancher2_cloud_credential" "cloud_credential" {
  name = var.RANCHER_CLOUD_CREDENTIAL
}

# Create a new rancher2 machine config v2 using harvester node_driver
resource "rancher2_machine_config_v2" "cn" {
  generate_name = "cn-config"
  harvester_config {
    vm_namespace = var.HARVESTER_NAMESPACE
    ssh_user = var.CN_SSH_USER
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
    user_data = <<EOF
    #cloud-config
    package_update: true
    packages:
      - qemu-guest-agent
      - iptables
    runcmd:
      - - systemctl enable --now qemu-guest-agent
    final_message: Ready, Set, GO!
    EOF
  }
}

resource "rancher2_machine_config_v2" "wn" {
  generate_name = "wn-config"
  harvester_config {
    vm_namespace = var.HARVESTER_NAMESPACE
    ssh_user = var.WN_SSH_USER
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
    user_data = <<EOF
    #cloud-config
    package_update: true
    packages:
      - iptables
      - open-iscsi
      - qemu-guest-agent
    runcmd:
      - - systemctl enable --now qemu-guest-agent
    final_message: Ready, Set, GO!
    EOF
  }
}

# Create a new harvester rke2 cluster with harvester cloud provider
resource "rancher2_cluster_v2" "cluster" {
  name = var.CLUSTER_NAME
  #fleet_namespace = var.CLUSTER_NAMESPACE
  kubernetes_version = var.K8S_VERSION
  enable_network_policy = false
  default_cluster_role_for_project_members = var.CLUSTER_ROLE
  rke_config {
    machine_pools {
      name = var.CN_POOL_NAME
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
      name = var.WN_POOL_NAME
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
        cloud-provider-name: ""
    EOF
    }
    machine_global_config = <<EOF
cni: "canal"
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
  cloudConfigPath: /var/lib/rancher/rke2/etc/config-files/cloud-provider-config
  clusterName: bc-test
EOF
  }
}






