# IaC Kubernetes Clusters
This is very much a work in progress...

Uses the Terraform Rancher provider to provision virtual machines in harvester and then configure them as either control nodes or worker nodes.

Edit variables in terraform.tfvars as needed.

`RANCHER_ACCESS_KEY` and `RANCHER_SECRET_KEY` variables are created in Rancher and stored elsewhere (CI/CD variables, Vault, etc.) and passed using `TF_VAR_` format.

### Working
- Connection to Rancher
- Provisioning virtual machines
- Seperate configs for control and worker nodes
- App installation

### Not Working
- Lots

### TODO
- Figure out autoscaling
- Figure out lifecycle to ignore node scaling done via UI
- Certificates
- Seperate values.yaml for app install

### NOTES
- opensuse-leap-15.5-minimal-vm.x86_64-cloud.qcow2 easiest to get everything working on (with latest Rancher, issues with Harvester v1.2.0+ and Rancher < v2.7.9ish)
- Istio requires Rancher Monitoring
- Longhorn requires open-iscsi on the nodes
- Iptables is needed on the nodes

### VERSIONS
- Rancher v2.7.9
- Harvester v1.2.1