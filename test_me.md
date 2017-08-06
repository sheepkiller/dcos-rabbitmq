You can test this framework, based on my latest successful build
```
$ dcos package repo remove rabbitmq-aws
$ dcos package repo add --index=0 rabbitmq-aws https://cotds-dcos-repo.s3.amazonaws.com/rabbitmq/rabbitmq/20170806-094847-v8m3NPwtch8s6ZBw/stub-universe-rabbitmq.json
$ dcos package install --yes rabbitmq
```
