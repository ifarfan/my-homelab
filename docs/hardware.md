# Hardware

Currently, running:
  - `3` macmini(s) as a **Proxmox** cluster
  - `1` stand-alone macmini as a **Proxmox Backup Server**
  - `2` **Raspberry Pis** for internal DNS and miscellaneous chores

```shell
# Proxmox Cluster
m0:
  Model:  Macmini8,1
  Memory: 64GB
  CPU:    12 logical / 6 CPUs x Intel(R) Core(TM) i7-8700B CPU @ 3.2GHz
  Disk:   512GB SSD
  IP-1:   192.168.136.10 (vmbr0: native ethernet / used for VMs + LXCs)
  IP-2:   192.168.136.50 (vmbr1: thunderbold ethernet / used for ceph-ONLY)

m1:
  Model:  Macmini6,2
  Memory: 16GB
  CPU:    8 logical / 4 CPUs x Intel(R) Core(TM) i7-3615QM CPU @ 2.30GHz
  Disk:   250GB SSD
  IP-1:   192.168.136.11 (vmbr0: native ethernet / used for VMs + LXCs)
  IP-2:   192.168.136.51 (vmbr1: thunderbold ethernet / used for ceph-ONLY)

m2:
  Model:  Macmini5,3
  Memory: 16GB
  CPU:    8 logical / 4 CPUs x Intel(R) Core(TM) i7-2635QM CPU @ 2.00GHz
  Disk:   250GB SSD
  IP-1:   192.168.136.12 (vmbr0: native ethernet / used for VMs + LXCs)
  IP-2:   192.168.136.52 (vmbr1: thunderbold ethernet / used for ceph-ONLY)

# Proxmox Backup Server
mbk:
  Model:  Macmini6,1
  Memory: 8GB
  CPU:    4 logical / 2 CPUs x Intel(R) Core(TM) i5-3210M CPU @ 2.50GHz
  Disk:   1TB SSD
  IP-1:   192.168.136.9  (native ethernet)
  IP-2:   192.168.136.49 (thunderbold ethernet)

# Raspberry Pis
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
