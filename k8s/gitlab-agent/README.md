# GitLab agent Helm chart

The official Helm chart for the client-side component (agentk) of the [GitLab agent for
Kubernetes](https://gitlab.com/gitlab-org/cluster-integration/gitlab-agent/).

For the server-side component (KAS), see the official [GitLab Helm chart](https://gitlab.com/gitlab-org/charts/gitlab)

## Getting started

### Prerequisites

This chart requires Helm v3.6 or later.

### Install the latest stable release

```shell
helm repo add gitlab https://charts.gitlab.io
helm repo update
helm upgrade --install gitlab-agent gitlab/gitlab-agent \
    --set config.kasAddress='wss://kas.gitlab.example.com' \
    --set config.token='YOUR.AGENT.TOKEN'
```

### Upgrade an existing release

```shell
helm repo update
helm upgrade  gitlab-agent gitlab/gitlab-agent --reuse-values
```

### Customize

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image | object | `{"pullPolicy":"IfNotPresent","repository":"registry.gitlab.com/gitlab-org/cluster-integration/gitlab-agent/agentk","tag":""}` | configure the used image |
| image.repository | string | `"registry.gitlab.com/gitlab-org/cluster-integration/gitlab-agent/agentk"` | used image repository |
| image.pullPolicy | string | `"IfNotPresent"` | set the `pullPolicy` |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | Optionally set `imagePullSecrets` |
| nameOverride | string | `""` | Override the default chart name |
| fullnameOverride | string | `""` | Override the full chart name |
| replicas | int | `2` | set number of replicas |
| maxSurge | int | `1` | set maxSurge for rolling update |
| maxUnavailable | int | `0` | set maxUnavailable for rolling update |
| rbac | object | `{"create":true,"useExistingRole":null}` | rbac settings |
| rbac.create | bool | `true` | Specifies whether RBAC resources should be created |
| rbac.useExistingRole | string | cluster-admin | Set to a rolename to use existing role. |
| serviceAccount | object | `{"annotations":{},"create":true,"name":null}` | serviceAccount settings |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | name is generated using the fullname template | The name of the service account to use. |
| podSecurityContext | object | `{}` | set podSecurityContext Example: `fsGroup: 2000` |
| securityContext | object | `{}` | set securityContext Example `{ "capabilities": { "drop": [ "ALL" ] }, "readOnlyRootFilesystem": true, "runAsNonRoot": true, "runAsUser": 1000 }` |
| podAnnotations | object | `{"prometheus.io/path":"/metrics","prometheus.io/port":"8080","prometheus.io/scrape":"true"}` | set podAnnotations |
| serviceMonitor.enabled | bool | `false` | Specifies whether to create a ServiceMonitor resource for collecting Prometheus metrics |
| config | object | `{"kasAddress":"wss://kas.gitlab.com","kasCaCert":null,"kasHeaders":[],"observability":{"enabled":true,"tls":{"cert":null,"enabled":false,"key":null,"secret":{"create":false,"name":"gitlab-agent-observability"}}},"operational_container_scanning":{"enabled":true},"secretName":null,"token":null}` | configure the agent |
| config.kasAddress | string | `"wss://kas.gitlab.com"` | The user-facing URL for the in-cluster `agentk` |
| config.kasHeaders | list | `[]` | add kas-headers Example: `[ "Cookie: gitlab-canary" ]` |
| config.token | string | `nil` | put your agent token here |
| config.secretName | string | `nil` | name of the secret storing the token |
| config.kasCaCert | string | `nil` | PEM certificate file to use to verify config.kasAddress. Useful if config.kasAddress is self-signed. |
| config.observability.tls | object | `{"cert":null,"enabled":false,"key":null,"secret":{"create":false,"name":"gitlab-agent-observability"}}` | Application-level TLS configuration for the observability service |
| config.observability.tls.enabled | bool | `false` | enable application-level TLS for the observability service |
| config.observability.tls.cert | string | `nil` | Public key for the TLS certificate for the observability service |
| config.observability.tls.key | string | `nil` | Private key for the TLS certificate for the observability service |
| config.observability.tls.secret.create | bool | `false` | when true, creates a certificate with values cert and key from  for the observability service |
| config.observability.tls.secret.name | string | `"gitlab-agent-observability"` | secret name for the observability service |
| config.operational_container_scanning.enabled | bool | `true` | enables automatic RBAC creation for the operational container scanning feature |
| extraEnv | list | `[]` | Add additional environment settings to the pod. Can be useful in proxy environments |
| extraArgs | list | `[]` | Add additional args settings to the pod. |
| extraVolumeMounts | list | `[]` | Add extra volume mounts |
| extraVolumes | list | `[]` | Add extra volumes |
| resources | object | `{}` | set resource parameters Example: `{ "limits": { "cpu": "100m", "memory": "128Mi" }, "requests": { "cpu": "100m", "memory": "128Mi" }}` |
| nodeSelector | object | `{}` | nodeSelector |
| tolerations | list | `[]` | tolerations |
| affinity | object | `{}` | set affinity |
| priorityClassName | string | `""` | set priorityClassName |
| runtimeClassName | string | `""` | set runtimeClassName |
| hostAliases | list | `[]` | list of hosts and IPs that will be injected into the pod's hosts file Example: `[{ "ip": "127.0.0.1", "hostnames": [ "foo.local", "bar.local" ]}, { "ip": "10.1.2.3", "hostnames": [ "foo.remote", "bar.remote" ]}]` |
| podLabels | object | `{}` | Labels to be added to each agent pod Example: `role: developer` |
| additionalLabels | object | `{}` | Additional labels to be added to all created objects |
| initContainers | list | `[]` | Optional initContainers definition |
| terminationMessagePolicy | string | `"FallbackToLogsOnError"` |  Show the last 80 lines or 2048 bytes (whichever is smaller) of pod logs in kubectl describe output when container exits with non-zero exit code # Useful for when pod logs are cycled out of a node post-crash before an operator can capture the logs Valid values are 'File' which is the Kubernetes API default, or 'FallbackToLogsOnError' See <https://kubernetes.io/docs/tasks/debug/debug-application/determine-reason-pod-failure/> for more information |

### Install from source

``` shell
git clone https://gitlab.com/gitlab-org/charts/gitlab-agent.git
cd gitlab-agent
helm upgrade --install gitlab-agent . \
    --set config.kasAddress='wss://kas.gitlab.example.com' \
    --set config.token='YOUR.AGENT.TOKEN'
```

## Development

See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for our contributor license agreement and code of conduct.

### Publishing a new release

1. When applicable: Update `appVersion` in [`Chart.yaml`](./Chart.yaml) with the latest [upstream release](https://gitlab.com/gitlab-org/cluster-integration/gitlab-agent/-/releases).
1. When changing any Helm chart resources (such as anything in [`templates`](./templates) or [`Chart.yaml`](./Chart.yaml)): Update `version` in [`Chart.yaml`](./Chart.yaml).
1. For a normal release: Create a tag `vX.Y.Z` where `X.Y.Z` is the `version` from `Chart.yaml` under https://gitlab.com/gitlab-org/charts/gitlab-agent
1. For a security release: Create a tag `vX.Y.Z` where `X.Y.Z` is the `version` from `Chart.yaml` under https://gitlab.com/gitlab-org/security/charts/gitlab-agent
   * **Note:** Security releases should be made in coordination with release managers. The GitLab agent has not had a security release yet, but see [the GitLab's security development workflow](https://gitlab.com/gitlab-org/release/docs/blob/master/general/security/developer.md) for the general process.

## Third-party trademarks

[Kubernetes](https://kubernetes.io/) is a registered trademark of The Linux Foundation.
