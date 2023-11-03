## Rancher
variable "RANCHER_URL" { }
variable "RANCHER_ACCESS_KEY" { }
variable "RANCHER_SECRET_KEY" { }
variable "RANCHER_CLOUD_CREDENTIAL" { }

## Cluster Config
variable "CLUSTER_NAME" { }
variable "RKE2VERSION" { }    

## Harvester
variable "HARVESTER_CLUSTER_ID" { }

## Controller Node Config
variable "CN_NUMNODES" { }
variable "CN_TEMPLATE" { }
variable "CN_CPUCOUNT" { }
variable "CN_MEMORY" { }
variable "CN_DISKSIZE" { }
variable "CN_NETWORK" { }

## Worker Node Config
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
