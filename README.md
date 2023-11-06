# IaC Kubernetes Clusters
This is very much a work in progress...

Uses the Terraform Rancher provider to provision virtual machines in harvester and then configure them as either control nodes or worker nodes.

Edit variables in terraform.tfvars as needed.

`RANCHER_ACCESS_KEY` and `RANCHER_SECRET_KEY` variables are created in Rancher and stored elsewhere (CI/CD variables, Vault, etc.) and passed using `TF_VAR_` format.

### Working
- Connection to Rancher
- Provisioning virtual machines
- Seperate configs for control and worker nodes
- Cluster creation with rhel-8.8-x86_64-kvm.qcow2
- Cluster creation with rhel-9.2-x86_64-kvm.qcow2

### Not Working
- Cluster creation with opensuse-leap-15.5-minimal-vm.x86_64-cloud.qcow2
- App installation (bug? tries to pull cluster schema from https://rancher.packet.loss:4343/v3/clusters/fleet-default/bc-test, it should be https://rancher.packet.loss:4343/v3/clusters/c-m-qjxx7tn7) 
- Lots!

### TODO
- Figure out autoscaling
- Figure out lifecycle to ignore node scaling done via UI
- App installation
- Certificates

### VERSIONS
- Rancher v2.7.9
- Harvester v1.2.1