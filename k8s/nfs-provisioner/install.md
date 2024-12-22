# install nfs provisioner in k8s  

## 1- first install nfs (network file share) in you of 

###   Update repository and install nfs kernel server

``` bash
sudo apt update
sudo apt install nfs-kernel-server
```

### create directory for share 

```bash
sudo mkdir /share/nfs-default-storage -p
```

### Assign user group of directory to nobody and nogroup

```bash
sudo chown nobody:nogroup /var/nfs/general
```

### Add your client for access the path for use directory

```bash
sudo nano /etc/exports
```

#### like follow syntax add your client 

```bash 
/etc/exports <client_ip>(rw,sync,no_root_squash,no_subtree_check)
/etc/exports 192.168.2.34(rw,sync,no_root_squash,no_subtree_check)
``` 

### restart the nfs server 

```bash
sudo systemctl restart nfs-kernel-server
```


## 2 - secound install chart 

### first edit yml file 

- add your server nfs ip 
- add the path of nfs

### add helm repo

```bash
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/ 
```
### udpate repo


```bash
helm repo update
```


### run follow command to install chart

```bash
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner -f  values.yml 
```