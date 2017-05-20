# Configure with parameters from `triton env` or `triton env $(PROFILE_NAME)`
provider "triton" {
  account      = "my-triton-account-name"   # Value from TRITON_PROFILE
  key_material = "${file("~/.ssh/id_rsa")}" # Path to your SSH key

  # Key ID from `triton keys` that matches the file used in key_material
  key_id = "de:ad:be:ef:c0:ff:ee:de:ad:be:ef:c0:ff:ee:be:ef"

  # URL from `triton datacenters`
  url = "https://us-west-1.api.joyentcloud.com"
}
