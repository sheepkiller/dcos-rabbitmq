[Test the latest development build](test_me.md)


---
# RabbitMQ Service Guide

## Table of Contents

- [Overview](#overview)
  - [Features](#features)

<a name="overview"></a>
# Overview

DC/OS RabbitMQ is an automated service that makes it easy to deploy and manage a RabbitMQ Cluster on [DC/OS](https://mesosphere.com/product/). It requires a pre-existing etcd cluster (v2 or v3). Currently, only deployment is supported. Several features are planned like "advanced configuration", monitoring and backup/restore configuration. Please note that it only bootstraps a cluster. If you need replicated queues you still need to configure them by you own. Please refer to [RabbitMQ Documentation](https://www.rabbitmq.com/clustering.html) for further details about cluster limitations and replicated queues.

<a name="features"></a>
## Features

- Single command installation for rapid provisioning
- Multiple RabbitMQ clusters sharing a single DC/OS cluster for multi-tenancy
- Placement constraints for fine-grained instance placement
- Vertical and horizontal for managing capacity
