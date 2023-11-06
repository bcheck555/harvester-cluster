### Rancher
RANCHER_URL = "https://rancher.packet.loss:4343"
RANCHER_CLOUD_CREDENTIAL = "harvester1"
RANCHER_CNI = "canal"

### Cluster Config
CLUSTER_NAME = "bc-test"
CLUSTER_NAMESPACE = "fleet-default"
K8S_VERSION = "v1.26.8+rke2r1"
CLUSTER_ROLE = "user"

### Harvester
HARVESTER_CLUSTER_ID = "c-m-6zh8gllf"
HARVESTER_NAMESPACE = "default"

### Controller Node Config
CN_POOL_NAME = "pool1"
CN_SSH_USER = "cloud-user"
CN_NUMNODES = 3
CN_CPUCOUNT = 2
CN_MEMORY = 4   #GB
CN_DISKSIZE = 40   #GB
CN_TEMPLATE = "default/image-tw8kb"
CN_NETWORK = "default/vlan20"

### Worker Node Config
WN_POOL_NAME = "pool2"
WN_SSH_USER = "cloud-user"
WN_NUMNODES = 3
WN_CPUCOUNT = 4
WN_MEMORY = 32  #GB
WN_DISKSIZE = 100   #GB
WN_TEMPLATE = "default/image-tw8kb"
WN_NETWORK = "default/vlan20" 

### Logging and Monitoring
# Monitoring chart
MONCHART = "102.0.2+up40.1.2"
# Logging chart
LOGCHART = "3.8.201"
# Time to wait for Kubernetes to deploy before installing
DELAYSEC = 780
