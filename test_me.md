You can test this framework, based on my latest successful build
```
$ dcos package repo remove rabbitmq-aws
$ dcos package repo add --index=0 rabbitmq-aws https://cotds-dcos-repo.s3.amazonaws.com/rabbitmq/rabbitmq/20170819-115811-6i5wycZ1MY3oj2nI/stub-universe-rabbitmq.json
$ dcos package install --yes rabbitmq
```
