# Terraform provider

# Rancher
provider "rancher2" {
  api_url = var.RANCHER_URL
  access_key = var.RANCHER_ACCESS_KEY
  secret_key = var.RANCHER_SECRET_KEY
}