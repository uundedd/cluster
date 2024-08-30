# Install k8s 

## Fix DNS for sanction

first change dns in /etc/resolve.conf 

```conf
nameserver 10.202.10.202
nameserver 10.202.10.102
```

## Fix node name 

run this command for change node name

```bash
sudo hostnamectl set-hostname "<your node name>"
```

edit hosts  file /etc/hosts

and add all node name in each node with follow syntax

```hosts
<node-ip> <your node name> 
```


## install k8s snapd version

run follow command in each node

```bash


```