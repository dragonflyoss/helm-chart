# Dragonfly Supernode Helm Chart

This directory contains a Kubernetes chart to deploy a private Dragonfly Supernode Server.

## Prerequisites Details

* Kubernetes 1.10+
* PV support on underlying infrastructure

## Chart Details

This chart will do the following:

* Implement a Dragonfly Supernode deployment

## Installing the Chart

To install the chart with the release name my-release, use the following:

```console
$ helm install --name my-release stable/dragonfly-supernode
```

## Deleting the Charts

Delete the Helm deployment as normal

```
$ helm delete my-release
```

## Configuration

The following table lists the configurable parameters of the dragonfly-supernode chart and
their default values.

| Parameter                   | Description                                                                                | Default         |
|:----------------------------|:-------------------------------------------------------------------------------------------|:----------------|
| `image.pullPolicy`          | Container pull policy                                                                      | `IfNotPresent`  |
| `image.repository`          | Container image to use                                                                     | `registry.cn-hangzhou.aliyuncs.com/alidragonfly/supernode`      |
| `image.tag`                 | Container image tag to deploy                                                              | `0.2.0`         |
| `persistence.accessMode`    | Access mode to use for PVC                                                                 | `ReadWriteOnce` |
| `persistence.enabled`       | Whether to use a PVC for storage                                                           | `false`         |
| `persistence.size`          | Amount of space to claim for PVC                                                           | `10Gi`          |
| `persistence.storageClass`  | Storage Class to use for PVC                                                               | `-`             |
| `persistence.existingClaim` | Name of an existing PVC to use for config                                                  | `nil`           |
| `service.type`              | service type                                                                               | `ClusterIP`     |
| `service.clusterIP`         | if `service.type` is `ClusterIP` and this is non-empty, sets the cluster IP of the service | `nil`           |
| `service.nodePort`          | if `service.type` is `NodePort` and this is non-empty, sets the node port of the service   | `nil`           |
| `server.port`               | The register port of the cluster member which is exposed                                   | `8001`          |
| `peer.port`                 | The download port of the cluster member which is exposed                                   | `8002`          |
| `replicaCount`              | k8s replicas                                                                               | `1`             |
| `updateStrategy`            | update strategy for deployment                                                             | `{}`            |
| `podAnnotations`            | Annotations for pod                                                                        | `{}`            |
| `resources.limits.cpu`      | Container requested CPU                                                                    | `nil`           |
| `resources.limits.memory`   | Container requested memory                                                                 | `nil`           |
| `nodeSelector`              | node labels for pod assignment                                                             | `{}`            |
| `tolerations`               | pod tolerations                                                                            | `[]`            |
| `ingress.enabled`           | If true, Ingress will be created                                                           | `false`         |
| `ingress.annotations`       | Ingress annotations                                                                        | `{}`            |
| `ingress.path`              | Ingress service path                                                                       | `/`            |
| `ingress.hosts`             | Ingress hostnames                                                                          | `[]`            |
| `ingress.tls`               | Ingress TLS configuration (YAML)                                                           | `[]`            |

Specify each parameter using the `--set key=value[,key=value]` argument to
`helm install`.

# TODO

* liveness and readliness.
* DragonFly Supernode configuration.