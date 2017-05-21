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

## Workaround for older versions of Packer

For versions of Packer older than 1.0.0 (unrelased as of 2017-05-21)
where [hashicorp/packer#4909](https://github.com/hashicorp/packer/pull/4909) had
not been merged yet, the following patch is required.  Apply with `patch -p1 <
pre-4909.patch`:

```
diff --git b/freebsd.json5 a/freebsd.json5
index 2f6eed9..396eb4b 100644
--- b/freebsd.json5
+++ a/freebsd.json5
@@ -50,6 +50,9 @@
     provisioners: [
         {
             type: "shell",
+            // Workaround until https://github.com/hashicorp/packer/pull/4909 is
+            // merged and released.
+            execute_command: "/bin/chmod +x {{ .Path }}; /usr/bin/env {{ .Vars }} {{ .Path }}",
             inline: [
                 "/usr/bin/uname -a",
 
```
