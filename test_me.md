You can test this framework, based on my latest successful build
```
$ dcos package repo remove rabbitmq-aws
$ dcos package repo add --index=0 rabbitmq-aws https://universe-converter.mesosphere.com/transform?url=https://cotds-dcos-repo.s3.amazonaws.com/rabbitmq/rabbitmq/20180303-160220-hlPbiP2UAblXQ8xZ/stub-universe-rabbitmq.json
$ dcos package install --yes rabbitmq
```
