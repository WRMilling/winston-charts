# TeamCity Helm Chart

TeamCity is a CI/CD server created by [JetBrains](https://www.jetbrains.com/teamcity/) which provides a "Free Forever" license. This chart will create a TeamCity deployment on [Kubernetes](https://kubernetes.io) using [Helm](https://github.com/helm/helm).

## Installing

```
$ helm repo add wrmilling https://wrmilling.github.io/wrmilling-charts/
$ helm install --name my-teamcity wrmilling/teamcity
```

## Uninstalling

```
$ helm delete my-teamcity
```

## Configuration

| Parameter               | Description                           | Default                                                    |
| ----------------------- | ----------------------------------    | ---------------------------------------------------------- |
| comingSoon | Parameters are coming soon | true |

## TODO

* How to cleanup any resources not covered by helm delete
* Management of the TeamCity agents
  * Adding
  * Deleting
  * Resources
* Any other TODO Items are... TODO
