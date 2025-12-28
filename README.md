# Helm chart for %%COMPONENT_NAME%%

[%%COMPONENT_NAME%%](https://github.com/%%COMPONENT_NAME%%), is a tool for 

## TL;DR

```console
$ helm install my-release oci://registry-1.docker.io/captnbp/%%COMPONENT_NAME%%
```

## Prerequisites

- Kubernetes 1.30+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure
- [cert-manager](https://cert-manager.io/)

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install my-release oci://registry-1.docker.io/captnbp/%%COMPONENT_NAME%%
```

These commands deploy %%COMPONENT_NAME%% on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` release:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release. Remove also the chart using `--purge` option:

```console
$ helm delete --purge my-release
```


## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |

### Common parameters

| Name                | Description                                                                                  | Value           |
| ------------------- | -------------------------------------------------------------------------------------------- | --------------- |
| `nameOverride`      | String to partially override common.names.fullname template (will maintain the release name) | `""`            |
| `fullnameOverride`  | String to fully override common.names.fullname template                                      | `""`            |
| `commonLabels`      | Labels to add to all deployed objects                                                        | `{}`            |
| `commonAnnotations` | Annotations to add to all deployed objects                                                   | `{}`            |
| `kubeVersion`       | Force target Kubernetes version (using Helm capabilities if not set)                         | `""`            |
| `clusterDomain`     | Default Kubernetes cluster domain                                                            | `cluster.local` |
| `extraDeploy`       | Array of extra objects to deploy with the release                                            | `[]`            |

### %%COMPONENT_NAME%% parameters

| Name                 | Description                                                                 | Value             |
| -------------------- | --------------------------------------------------------------------------- | ----------------- |
| `image.registry`     | %%COMPONENT_NAME%% image registry                                                        | `docker.io`       |
| `image.repository`   | %%COMPONENT_NAME%% image repository                                                      | `hashicorp/%%COMPONENT_NAME%%` |
| `image.tag`          | %%COMPONENT_NAME%% image tag (immutable tags are recommended)                            | `1.21.0`          |
| `image.pullPolicy`   | Image pull policy                                                           | `IfNotPresent`    |
| `image.pullSecrets`  | Specify docker-registry secret names as an array                            | `[]`              |
| `image.debug`        | Specify if debug logs should be enabled                                     | `false`           |
| `extraEnvVars`       | Extra environment variables to be set on %%COMPONENT_NAME%% container                    | `{}`              |
| `extraEnvVarsCM`     | ConfigMap with extra environment variables                                  | `""`              |
| `extraEnvVarsSecret` | Secret with extra environment variables                                     | `""`              |
| `command`            | Default container command (useful when using custom images). Use array form | `[]`              |
| `args`               | Default container args (useful when using custom images). Use array form    | `[]`              |

### %%COMPONENT_NAME%% deployment/statefulset parameters

| Name                                                | Description                                                                                            | Value            |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ---------------- |
| `schedulerName`                                     | Specifies the schedulerName, if it's nil uses kube-scheduler                                           | `""`             |
| `updateStrategy.type`                               | %%COMPONENT_NAME%%warden statefulset strategy type                                                                  | `RollingUpdate`  |
| `updateStrategy.rollingUpdate`                      | %%COMPONENT_NAME%%warden statefulset rolling update configuration parameters                                        | `{}`             |
| `hostAliases`                                       | %%COMPONENT_NAME%% pod host aliases                                                                                 | `[]`             |
| `containerPorts.http`                               | %%COMPONENT_NAME%% container port to open for %%COMPONENT_NAME%% http                                                            | `8200`           |
| `podSecurityContext.enabled`                        | Enable pod Security Context                                                                            | `true`           |
| `podSecurityContext.fsGroup`                        | Group ID for the container                                                                             | `1000`           |
| `podSecurityContext.runAsNonRoot`                   | Run as non-root user                                                                                   | `true`           |
| `podSecurityContext.runAsGroup`                     | Group ID to run the container as                                                                       | `1000`           |
| `podSecurityContext.runAsUser`                      | User ID to run the container as                                                                        | `1000`           |
| `podSecurityContext.seccompProfile.type`            | Type of seccomp profile to use                                                                         | `RuntimeDefault` |
| `containerSecurityContext.enabled`                  | Enable container Security Context                                                                      | `true`           |
| `containerSecurityContext.runAsUser`                | User ID for the container                                                                              | `1000`           |
| `containerSecurityContext.runAsNonRoot`             | Avoid running as root User                                                                             | `true`           |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation                                                                             | `false`          |
| `containerSecurityContext.readOnlyRootFilesystem`   | Read-only root filesystem                                                                              | `true`           |
| `containerSecurityContext.capabilities.drop`        | Capabilities to drop                                                                                   | `["ALL"]`        |
| `containerSecurityContext.capabilities.add`         | Capabilities to add                                                                                    | `["IPC_LOCK"]`   |
| `podLabels`                                         | Extra labels for %%COMPONENT_NAME%% pods                                                                            | `{}`             |
| `podAnnotations`                                    | Annotations for %%COMPONENT_NAME%% pods                                                                             | `{}`             |
| `podAffinityPreset`                                 | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                    | `""`             |
| `podAntiAffinityPreset`                             | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`               | `soft`           |
| `nodeAffinityPreset.type`                           | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`              | `""`             |
| `nodeAffinityPreset.key`                            | Node label key to match. Ignored if `affinity` is set.                                                 | `""`             |
| `nodeAffinityPreset.values`                         | Node label values to match. Ignored if `affinity` is set.                                              | `[]`             |
| `affinity`                                          | Affinity for pod assignment. Evaluated as a template.                                                  | `{}`             |
| `nodeSelector`                                      | Node labels for pod assignment. Evaluated as a template.                                               | `{}`             |
| `tolerations`                                       | Tolerations for pod assignment. Evaluated as a template.                                               | `[]`             |
| `topologySpreadConstraints`                         | Topology Spread Constraints for %%COMPONENT_NAME%% pods assignment spread across your cluster among failure-domains | `[]`             |
| `priorityClassName`                                 | %%COMPONENT_NAME%% pods' priorityClassName                                                                          | `""`             |
| `resources.limits`                                  | The resources limits for the %%COMPONENT_NAME%% container                                                           | `{}`             |
| `resources.requests`                                | The requested resources for the %%COMPONENT_NAME%% container                                                        | `{}`             |
| `livenessProbe.enabled`                             | Enable livenessProbe                                                                                   | `false`          |
| `livenessProbe.initialDelaySeconds`                 | Initial delay seconds for livenessProbe                                                                | `5`              |
| `livenessProbe.periodSeconds`                       | Period seconds for livenessProbe                                                                       | `5`              |
| `livenessProbe.timeoutSeconds`                      | Timeout seconds for livenessProbe                                                                      | `5`              |
| `livenessProbe.failureThreshold`                    | Failure threshold for livenessProbe                                                                    | `5`              |
| `livenessProbe.successThreshold`                    | Success threshold for livenessProbe                                                                    | `1`              |
| `readinessProbe.enabled`                            | Enable readinessProbe                                                                                  | `true`           |
| `readinessProbe.initialDelaySeconds`                | Initial delay seconds for readinessProbe                                                               | `5`              |
| `readinessProbe.periodSeconds`                      | Period seconds for readinessProbe                                                                      | `5`              |
| `readinessProbe.timeoutSeconds`                     | Timeout seconds for readinessProbe                                                                     | `1`              |
| `readinessProbe.failureThreshold`                   | Failure threshold for readinessProbe                                                                   | `5`              |
| `readinessProbe.successThreshold`                   | Success threshold for readinessProbe                                                                   | `1`              |
| `startupProbe.enabled`                              | Enable startupProbe                                                                                    | `false`          |
| `startupProbe.initialDelaySeconds`                  | Initial delay seconds for startupProbe                                                                 | `0`              |
| `startupProbe.periodSeconds`                        | Period seconds for startupProbe                                                                        | `10`             |
| `startupProbe.timeoutSeconds`                       | Timeout seconds for startupProbe                                                                       | `5`              |
| `startupProbe.failureThreshold`                     | Failure threshold for startupProbe                                                                     | `60`             |
| `startupProbe.successThreshold`                     | Success threshold for startupProbe                                                                     | `1`              |
| `customLivenessProbe`                               | Override default liveness probe                                                                        | `{}`             |
| `customReadinessProbe`                              | Override default readiness probe                                                                       | `{}`             |
| `customStartupProbe`                                | Override default startup probe                                                                         | `{}`             |
| `lifecycleHooks`                                    | for the %%COMPONENT_NAME%% container(s) to automate configuration before or after startup                           | `{}`             |
| `extraVolumes`                                      | Optionally specify extra list of additional volumes for %%COMPONENT_NAME%% pods                                     | `[]`             |
| `extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts for %%COMPONENT_NAME%% container(s)                        | `[]`             |
| `initContainers`                                    | Add additional init containers to the %%COMPONENT_NAME%% pods                                                       | `[]`             |
| `sidecars`                                          | Add additional sidecar containers to the %%COMPONENT_NAME%% pods                                                    | `[]`             |

### Exposure parameters

| Name                               | Description                                                                                                                      | Value                    |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `service.type`                     | Kubernetes service type                                                                                                          | `ClusterIP`              |
| `service.ports.http`               | %%COMPONENT_NAME%% service HTTP port                                                                                                          | `8200`                   |
| `service.nodePorts`                | Specify the nodePort values for the LoadBalancer and NodePort service types.                                                     | `{}`                     |
| `service.sessionAffinity`          | Control where client requests go, to the same pod or round-robin                                                                 | `None`                   |
| `service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                                      | `{}`                     |
| `service.clusterIP`                | %%COMPONENT_NAME%% service clusterIP IP                                                                                                       | `""`                     |
| `service.loadBalancerIP`           | loadBalancerIP for the SuiteCRM Service (optional, cloud specific)                                                               | `""`                     |
| `service.loadBalancerSourceRanges` | Address that are allowed when service is LoadBalancer                                                                            | `[]`                     |
| `service.externalTrafficPolicy`    | Enable client source IP preservation                                                                                             | `Cluster`                |
| `service.annotations`              | Additional custom annotations for %%COMPONENT_NAME%% service                                                                                  | `{}`                     |
| `service.extraPorts`               | Extra port to expose on %%COMPONENT_NAME%% service                                                                                            | `[]`                     |
| `service.extraHeadlessPorts`       | Extra ports to expose on %%COMPONENT_NAME%% headless service                                                                                  | `[]`                     |
| `service.ipFamilyPolicy`           | Controller Service ipFamilyPolicy (optional, cloud specific)                                                                     | `PreferDualStack`        |
| `service.ipFamilies`               | Controller Service ipFamilies (optional, cloud specific)                                                                         | `[]`                     |
| `ingress.enabled`                  | Enable ingress record generation for %%COMPONENT_NAME%%                                                                                       | `true`                   |
| `ingress.pathType`                 | Ingress path type                                                                                                                | `ImplementationSpecific` |
| `ingress.apiVersion`               | Force Ingress API version (automatically detected if not set)                                                                    | `""`                     |
| `ingress.hostname`                 | Default host for the ingress record                                                                                              | `%%COMPONENT_NAME%%.local`            |
| `ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `nginx`                  |
| `ingress.ingressControllerType`    | ingressControllerType that will be be used to implement the Ingress specific annotations (Ex. nginx or traefik)                  | `nginx`                  |
| `ingress.path`                     | Default path for the ingress record                                                                                              | `/`                      |
| `ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                     |
| `ingress.tls`                      | Enable TLS configuration for the host defined at `ingress.hostname` parameter                                                    | `false`                  |
| `ingress.selfSigned`               | Create a TLS secret for this ingress record using self-signed certificates generated by Helm                                     | `false`                  |
| `ingress.extraHosts`               | An array with additional hostname(s) to be covered with the ingress record                                                       | `[]`                     |
| `ingress.extraPaths`               | An array with additional arbitrary paths that may need to be added to the ingress under the main host                            | `[]`                     |
| `ingress.extraTls`                 | TLS configuration for additional hostname(s) to be covered with this ingress record                                              | `[]`                     |
| `ingress.secrets`                  | Custom TLS certificates as secrets                                                                                               | `[]`                     |
| `ingress.extraRules`               | Additional rules to be covered with this ingress record                                                                          | `[]`                     |

### RBAC parameter

| Name                                          | Description                                                  | Value   |
| --------------------------------------------- | ------------------------------------------------------------ | ------- |
| `serviceAccount.create`                       | Enable the creation of a ServiceAccount for %%COMPONENT_NAME%%warden pods | `true`  |
| `serviceAccount.name`                         | Name of the created ServiceAccount                           | `""`    |
| `serviceAccount.automountServiceAccountToken` | Auto-mount the service account token in the pod              | `false` |
| `serviceAccount.annotations`                  | Additional custom annotations for the ServiceAccount         | `{}`    |

### Persistence parameters

| Name                        | Description                                                     | Value               |
| --------------------------- | --------------------------------------------------------------- | ------------------- |
| `persistence.enabled`       | Enable %%COMPONENT_NAME%% data persistence using PVC. If false, use emptyDir | `true`              |
| `persistence.storageClass`  | PVC Storage Class for %%COMPONENT_NAME%% data volume                         | `""`                |
| `persistence.mountPath`     | Data volume mount path                                          | `/var/lib/%%COMPONENT_NAME%%`    |
| `persistence.accessModes`   | PVC Access Modes for %%COMPONENT_NAME%% data volume                          | `["ReadWriteOnce"]` |
| `persistence.size`          | PVC Storage Request for %%COMPONENT_NAME%% data volume                       | `8Gi`               |
| `persistence.annotations`   | Annotations for the PVC                                         | `{}`                |
| `persistence.existingClaim` | Name of an existing PVC to use (only in `standalone` mode)      | `""`                |

### Global TLS settings for internal CA

| Name                               | Description                                                                                | Value             |
| ---------------------------------- | ------------------------------------------------------------------------------------------ | ----------------- |
| `tls.enabled`                      | Enable internal TLS between Ingress controller and unifi                                   | `true`            |
| `tls.autoGenerated`                | Create cert-manager signed TLS certificates.                                               | `true`            |
| `tls.existingSecret`               | Existing secret containing the certificates for Unifi                                      | `""`              |
| `tls.subject.organizations`        | Subject's organization                                                                     | `%%COMPONENT_NAME%%`           |
| `tls.subject.countries`            | Subject's country                                                                          | `fr`              |
| `tls.issuerRef.existingIssuerName` | Existing name of the cert-manager http issuer. If provided, it won't create a default one. | `""`              |
| `tls.issuerRef.kind`               | Kind of the cert-manager issuer resource (defaults to "Issuer")                            | `Issuer`          |
| `tls.issuerRef.group`              | Group of the cert-manager issuer resource (defaults to "cert-manager.io")                  | `cert-manager.io` |

### Prometheus metrics

| Name                                       | Description                                                                                            | Value   |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------ | ------- |
| `metrics.enabled`                          | Enable the export of Prometheus metrics                                                                | `false` |
| `metrics.serviceMonitor.enabled`           | if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`) | `false` |
| `metrics.serviceMonitor.namespace`         | Namespace in which Prometheus is running                                                               | `""`    |
| `metrics.serviceMonitor.annotations`       | Additional custom annotations for the ServiceMonitor                                                   | `{}`    |
| `metrics.serviceMonitor.labels`            | Extra labels for the ServiceMonitor                                                                    | `{}`    |
| `metrics.serviceMonitor.jobLabel`          | The name of the label on the target service to use as the job name in Prometheus                       | `""`    |
| `metrics.serviceMonitor.honorLabels`       | honorLabels chooses the metric's labels on collisions with target labels                               | `false` |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped.                                                           | `""`    |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                                | `""`    |
| `metrics.serviceMonitor.metricRelabelings` | Specify additional relabeling of metrics                                                               | `[]`    |
| `metrics.serviceMonitor.relabelings`       | Specify general relabeling                                                                             | `[]`    |
| `metrics.serviceMonitor.selector`          | Prometheus instance selector labels                                                                    | `{}`    |

## License

[MIT](./LICENSE).

## Author

This Helm chart was created and is being maintained by @captnbp.

### Credits

- The `%%COMPONENT_NAME%%` project can be found [here](https://github.com/%%COMPONENT_NAME%%)
