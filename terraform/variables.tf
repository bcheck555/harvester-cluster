## Rancher
variable "RANCHER_URL" { }
variable "RANCHER_ACCESS_KEY" { }
variable "RANCHER_SECRET_KEY" { }
variable "RANCHER_CLOUD_CREDENTIAL" { }
variable "RANCHER_CNI" { }

## Cluster Config
variable "CLUSTER_NAME" { }
variable "CLUSTER_NAMESPACE" { }
variable "K8S_VERSION" { }
variable "CLUSTER_ROLE" { }

## Harvester
variable "HARVESTER_CLUSTER_ID" { }
variable "HARVESTER_NAMESPACE" { }

## Controller Node Config
variable "CN_POOL_NAME" { }
variable "CN_SSH_USER" { }
variable "CN_NUMNODES" { }
variable "CN_TEMPLATE" { }
variable "CN_CPUCOUNT" { }
variable "CN_MEMORY" { }
variable "CN_DISKSIZE" { }
variable "CN_NETWORK" { }

## Worker Node Config
variable "WN_POOL_NAME" { }
variable "WN_SSH_USER" { }
variable "WN_NUMNODES" { }
variable "WN_TEMPLATE" { }
variable "WN_CPUCOUNT" { }
variable "WN_MEMORY" { }
variable "WN_DISKSIZE" { }
variable "WN_NETWORK" { }

## Logging and Monitoring
# Monitoring chart
variable "MONCHART" {
	default = "9.4.202"
}
# Logging chart
variable "LOGCHART" {
	default = "3.8.201"
}
# Time to wait for Kubernetes to deploy before installing
variable "DELAYSEC" {
	default = 780
}
