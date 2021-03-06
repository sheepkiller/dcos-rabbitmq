[Test the latest development build](test_me.md)

---
⚠️  tested on DC/OS CE only -- neither secrets, nor TLS are supported ⚠️
---

# RabbitMQ Service Guide

## Table of Contents

- [Overview](#overview)
  - [Features](#features)
- [Quick Start](#quick-start)

<a name="overview"></a>
# Overview

DC/OS RabbitMQ is an automated service that makes it easy to deploy and manage a RabbitMQ Cluster on [DC/OS](https://mesosphere.com/product/). It requires a pre-existing etcd cluster (v2 or v3). Currently, only deployment is supported. Several features are planned like "advanced configuration", monitoring and backup/restore configuration. Please note that it only bootstraps a cluster. If you need replicated queues you still need to configure them by you own. Please refer to [RabbitMQ Documentation](https://www.rabbitmq.com/clustering.html) for further details about cluster limitations and replicated queues.

<a name="features"></a>
## Features

- Single command installation for rapid provisioning
- Multiple RabbitMQ clusters sharing a single DC/OS cluster for multi-tenancy
- Placement constraints for fine-grained instance placement
- Vertical and horizontal for managing capacity
- Backup/restore definitions from s3

<a name="quick-start"></a>
# Quick Start
### Prerequirements

1. Install DC/OS on your cluster. See [the documentation](https://docs.mesosphere.com/latest/administration/installing/) for instructions.

2. This package requires a running etcd cluster. A package is available package in DC/OS Universe.
  ```
  dcos package install etcd
  ```
3. Add the repository to DC/OS. See [test_me.md](test_me.md)

### Install
1. If you are using open source DC/OS, install RabbitMQ cluster with the following command from the DC/OS CLI. If you are using Enterprise DC/OS, you may need to follow additional instructions. See the Install and Customize section for more information. Please refer to []

	```
	dcos package install rabbitmq
	```

	You can also install _rabbitmq_ from [the DC/OS web interface](https://docs.mesosphere.com/latest/usage/webinterface/).

1. The service will now deploy with a default configuration. You can monitor its deployment from the Services tab of the DC/OS web interface.

2. Now you have 3 pods running etcd-proxy and rabbitmq server. Cluster should be up by now. The service service expose two endpoints per node : amqp, for messaging, and management, to access rabbitmq web console and its API. We also advertise a load balanced VIP for each endpoints.

```
	$ dcos rabbitmq endpoints
    [
      "amqp",
      "management"
    ]

	$ dcos rabbitmq endpoints amqp
    {
      "address": [
        "192.168.100.27:5672",
        "192.168.100.30:5672",
        "192.168.100.8:5672"
      ],
      "dns": [
        "rabbitmq-0-node.rabbitmq.autoip.dcos.thisdcos.directory:5672",
        "rabbitmq-1-node.rabbitmq.autoip.dcos.thisdcos.directory:5672",
        "rabbitmq-2-node.rabbitmq.autoip.dcos.thisdcos.directory:5672"
      ],
      "vip": "amqp.rabbitmq.l4lb.thisdcos.directory:5672"
    }

  $ dcos rabbitmq endpoints management
    {
      "address": [
        "192.168.100.27:15672",
        "192.168.100.30:15672",
        "192.168.100.8:15672"
      ],
      "dns": [
        "rabbitmq-0-node.rabbitmq.autoip.dcos.thisdcos.directory:15672",
        "rabbitmq-1-node.rabbitmq.autoip.dcos.thisdcos.directory:15672",
        "rabbitmq-2-node.rabbitmq.autoip.dcos.thisdcos.directory:15672"
      ],
      "vip": "management.rabbitmq.l4lb.thisdcos.directory:15672"
    }

```

  3. Now connect
