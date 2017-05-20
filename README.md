# Using FreeBSD on Joyent

A small [`packer`](https://www.packer.io/) template
and [`terraform`](https://www.terraform.io/) config to:

* build a custom FreeBSD image on Triton
* Provision the custom FreeBSD image on Triton (or use one of the stock images)

See the comments in
[`freebsd.json5`](https://github.com/sean-/joyent-freebsd/blob/master/freebsd.json5),
[`provider.tf`](https://github.com/sean-/joyent-freebsd/blob/master/provider.tf),
[`servers.tf`](https://github.com/sean-/joyent-freebsd/blob/master/servers.tf),
and
[`GNUmakefile`](https://github.com/sean-/joyent-freebsd/blob/master/GNUmakefile)
for details.
