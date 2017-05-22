resource "triton_machine" "my-freebsd-server" {
  name = "my-freebsd${format("%02d", count.index + 1)}"

  # Package name from `make packages`
  package = "k4-highcpu-kvm-250M"

  # Not covered in this example
  firewall_enabled = false

  count = 1

  # Image ID from the output of the packer run, or `make my-images`
  image = "312a6154-52d5-469c-9300-2cd246659ff6"

  nic {
    # ID from `make networks`, the network must be in the same data center as
    # the image
    network = "01234567-89ab-cdef-0123-456789abcdef"
  }

  # Arbitrary tags, useful with firewalls
  tags = {
    freebsd    = "11"
    app        = "my-image-app"
    image_type = "freebsd"
  }
}
