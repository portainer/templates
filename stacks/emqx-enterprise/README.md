# EMQX Enterprise on Docker Swarm

`docker-stack.yml` deploys EMQX Enterprise 6.3.2 with three core nodes and
three replicant nodes by default. Replicants accept client connections through
Swarm's routing mesh; change `EMQX_REPLICANT_NODES` to scale them.

## Prepare the Swarm

Run the following on a Swarm manager, replacing the node names with your own:

```sh
docker node update --label-add emqx.core-1=true swarm-node-1
docker node update --label-add emqx.core-2=true swarm-node-2
docker node update --label-add emqx.core-3=true swarm-node-3
```

Assign each label to exactly one Linux node. Use three different hosts for high
availability. For a local demonstration, all three labels can be assigned to one
node, but that does not provide host fault tolerance. Replicants can run on any
Linux node in the Swarm, including the core hosts.

For a single-node local Swarm, apply all three labels to the current manager:

```sh
docker node update \
  --label-add emqx.core-1=true \
  --label-add emqx.core-2=true \
  --label-add emqx.core-3=true \
  "$(docker info --format '{{.Swarm.NodeID}}')"
```

These labels are required even for a local demonstration. Without them, the core
tasks stay pending with `scheduling constraints not satisfied`, and replicants
cannot finish starting because no core nodes are available.

Each core is a single-replica service with a stable EMQX node name, its own local
data volume, and a placement constraint. Static discovery uses the core aliases
`emqx-core-1.internal`, `emqx-core-2.internal`, and `emqx-core-3.internal` on a
private overlay network. The cores use DNS round-robin so their names resolve
directly to their containers. Do not scale a core service above one replica:
its node identity and volume must be exclusive to that core.

## Deploy with Portainer

Select **EMQX Enterprise (Swarm)** from the app templates on a Swarm environment
and provide:

| Input | Value |
| --- | --- |
| Cluster cookie | A random secret shared by all nodes, for example from `openssl rand -hex 32` |
| EMQX License Key | A license that permits clustering, or `evaluation` for a trial |
| Dashboard username | Defaults to `admin` |
| Dashboard password | Required; used when initializing the cluster |
| Number of replicant nodes | Defaults to `3`; use a positive integer |

To use a custom stack template instead, select the Swarm platform and point it
at this repository and `stacks/emqx-enterprise/docker-stack.yml`.

To deploy from the command line, export the inputs in the shell, then run:

```sh
export EMQX_NODE__COOKIE='<shared-cluster-secret>'
export EMQX_LICENSE_KEY='<license-key-or-evaluation>'
export EMQX_DASHBOARD__DEFAULT_PASSWORD='<dashboard-password>'
export EMQX_DASHBOARD__DEFAULT_USERNAME=admin
export EMQX_REPLICANT_NODES=3

docker stack config -c stacks/emqx-enterprise/docker-stack.yml
docker stack deploy -c stacks/emqx-enterprise/docker-stack.yml emqx
docker stack services emqx
```

`docker stack config` prints resolved values, including the supplied secrets.
Swarm CLI deployment does not automatically read a Compose `.env` file.

## Connect and verify

Open `http://<swarm-node-ip>:18083` and log in with the supplied dashboard
credentials. The cluster should contain three cores and the requested number of
replicants. On the host running a core, its container console also supports:

```sh
/opt/emqx/bin/emqx ctl cluster status
```

The routing mesh publishes MQTT on `1883`, MQTT over WebSocket on `8083`, MQTT
over TLS on `8883`, MQTT over secure WebSocket on `8084`, and the dashboard on
`18083`. The core services do not publish host ports. Configure client
authentication and your own TLS certificates before exposing the broker to
clients; the dashboard credentials do not authenticate MQTT clients.

## Storage, recovery, and updates

Core data survives task replacement on the same host. Docker's local volumes do
not follow a task to another host, so a core remains pending if its labelled host
is unavailable. Recover that host and its volume, or follow EMQX's backup and
cluster recovery procedures before moving its label. Keep each label on one host
and preserve the stack name to reuse the existing volumes. Do not point several
cores at the same writable directory on shared storage.

Replicants use their unique Swarm task names for discovery, have private,
ephemeral data volumes, and rejoin the cores when replaced. Their local state is
discarded; do not rely on those volumes for durable sessions, local integration
queues, or other persistent workload data.
Client connections on a replaced replicant must reconnect.

Update or restart cores one at a time, waiting for each to be healthy and back in
the cluster. A stack-wide change can update all three core services concurrently;
the per-service update policy does not serialize different services. Replicant
updates proceed one task at a time. Back up the cluster before upgrades.

## References

- [EMQX cluster documentation](https://docs.emqx.com/en/emqx/latest/guides/cluster/create-cluster.html),
- [EMQX Docker installation guide](https://docs.emqx.com/en/emqx/latest/get-started/deploy/install-docker.html),
- [Docker service volume documentation](https://docs.docker.com/reference/cli/docker/service/create/#create-a-service-using-a-named-volume)
