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
sudo snap install k8s --channel=1.30-classic/beta --classic
```
## run k8s master 
run follow command on master node 

```bash 
sudo k8s bootstrap
```

## join worker node

first get token key in master node 

```bash
sudo k8s get-join-token <worker-hostname> --worker
```

after that for join worker node add follow command in worker node

```bash
sudo k8s join-cluster <token>
```

## ingress-service (optional)

in cilium-ingress service change 

```yml
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30225
    - name: https
      protocol: TCP
      port: 443
      targetPort: 443
      nodePort: 31914
  clusterIP: 10.152.183.72
  clusterIPs:
    - 10.152.183.72
  type: loadBlance
```

to 

```yml
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30225
    - name: https
      protocol: TCP
      port: 443
      targetPort: 443
      nodePort: 31914
  clusterIP: 10.152.183.72
  clusterIPs:
    - 10.152.183.72
  type: NodePort
```

## simple port forward 

install socat

```bash 
apt-get update 
apt-get  install socat 
```
run follow command for port forward


```bash
socat TCP-LISTEN:<host-port>,fork TCP:<destinition-address>:<destinition-port> & 
```

for example local port 80 to 30244

```bash
socat TCP-LISTEN:80,fork TCP:0.0.0.0:30244 & 
```

also you can use internet ip address instead 0.0.0.0



## Other config 

you can read more in this document 
https://documentation.ubuntu.com/canonical-kubernetes/latest/


## other related command


### for download chart from repository 
for example download harbor chart from harbor repository 

helm fetch harbor/harbor --untar