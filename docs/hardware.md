# Hardware

Currently, running `1` macmini(s) as a **Proxmox** cluster

```shell
m0:
  Model:  Macmini8,1
  Memory: 64GB
  CPU:    12 logical / 6 CPUs x Intel(R) Core(TM) i7-8700B CPU @ 3.2GHz
  Disk:   512GB SSD
  IP:     192.168.136.10
```

And, `2` **Raspberry Pis** for internal DNS and miscellaneous tasks:
```shell
rpi0:
  Model:  Pi 5
  Memory: 8GB
  CPU:    4 CPUs aarch64 @ 2.4 GHz
  Disk:   256GB microSDXC
  IP:     192.168.136.2

rpi1:
  Model:  Pi 5
  Memory: 8GB
  CPU:    4 CPUs aarch64 @ 2.4 GHz
  Disk:   256GB microSDXC
  IP:     192.168.136.3
```
