## Rancher
RANCHER_URL = "https://rancher.packet.loss:4343"
RANCHER_CLOUD_CREDENTIAL = "harvester1"


## Cluster Config
CLUSTER_NAME = "bc-test"
RKE2VERSION = "v1.23.17+rke2r1"
#DOCKERURL = "https://releases.rancher.com/install-docker/19.03.sh"

## Harvester
HARVESTER_CLUSTER_ID = "c-m-r4btfl67"

## Controller Node Config 
CN_NUMNODES = 1
CN_TEMPLATE = "default/image-stv28"
CN_CPUCOUNT = 2
CN_MEMORY = 4   #GB
CN_DISKSIZE = 40   #GB
CN_NETWORK = "default/vlan20"

## Worker Node Config 
WN_NUMNODES = 1
WN_TEMPLATE = "default/image-stv28"
WN_CPUCOUNT = 8
WN_MEMORY = 32  #GB
WN_DISKSIZE = 100   #GB
WN_NETWORK = "default/vlan20"

## Logging and Monitoring
# Monitoring chart
MONCHART = "9.4.202"
# Logging chart
LOGCHART = "3.8.201"
# Time to wait for Kubernetes to deploy before installing
DELAYSEC = 780
