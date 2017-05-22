# Configure with parameters from `triton env` or `triton env $(PROFILE_NAME)`
provider "triton" {
  # Triton account information. Example:
  #
  # $ make env | grep ^SDC_ACCOUNT | cut -d '=' -f2
  account      = "my-triton-account-name"

  # Path to your SSH key
  key_material = "${file("~/.ssh/id_rsa")}"

  # Key ID from `triton keys` that matches the file used in key_material. Example:
  #
  # $ make env | grep ^SDC_KEY_ID | cut -d '=' -f2
  key_id = "de:ad:be:ef:c0:ff:ee:de:ad:be:ef:c0:ff:ee:be:ef"

  # URL from `triton datacenters`.  Example:
  #
  # $ make env | grep ^SDC_URL | cut -d '=' -f2
  url = "https://us-west-1.api.joyentcloud.com"
}
