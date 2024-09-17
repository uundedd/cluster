# install k8s connection 

## requirement 

before install create repository in gitlab name k8s-connection

create empty file in ".gitlab/agents/gitlab-kas/config.yaml" path 

open menu  Operate > kubernetes clusters page (side menu of k8s-connection repository)

cleate connection cluster menu and choose the k8s-connection repository

you must see below text

```bash
token : glagent-_D1ubuGyZQmgYQ-6ZujGiRqWsza38L6i5TQzKiiSLxjpS7A4Tw

helm repo add gitlab https://charts.gitlab.io
helm repo update
helm upgrade --install gitlab-kas gitlab/gitlab-agent \
    --namespace gitlab-agent-gitlab-kas \
    --create-namespace \
    --set image.tag=v17.3.1 \
    --set config.token=glagent-_D1ubuGyZQmgYQ-6ZujGiRqWsza38L6i5TQzKiiSLxjpS7A4Tw \
    --set config.kasAddress=wss://kagent.kgit.webpooyan.com
```
first 

- replace kasAddress in config.kasAddress of value.yml file
- replace token in config.token of value.yml file

after that 

create name space with follow command

```bash
kubectl create namespace gitlab-agent-gitlab-kas
```

install chart with follow command

```bash
helm install --namespace gitlab-agent-gitlab-kas gitlab-agent . 
```



## other documentation 

for more detail for access k8s 