FROM rabbitmq:3.6.10-management

ENV RABBITMQ_VERSION=3.6.10 \
    AUTOCLUSTER_VERSION=0.8.0 \
    ETCD_BIN_VERSION=2.2.1

RUN apt-get update  -y && \
    apt-get install -y wget curl && \
    wget -O /usr/lib/rabbitmq/lib/rabbitmq_server-${RABBITMQ_VERSION}/plugins/autocluster-${AUTOCLUSTER_VERSION}.ez \
            https://github.com/rabbitmq/rabbitmq-autocluster/releases/download/${AUTOCLUSTER_VERSION}/autocluster-${AUTOCLUSTER_VERSION}.ez && \
    wget -O  /usr/lib/rabbitmq/lib/rabbitmq_server-${RABBITMQ_VERSION}/plugins/rabbitmq_aws-${AUTOCLUSTER_VERSION}.ez \
             https://github.com/rabbitmq/rabbitmq-autocluster/releases/download/${AUTOCLUSTER_VERSION}/rabbitmq_aws-${AUTOCLUSTER_VERSION}.ez && \
    wget -qO - https://github.com/coreos/etcd/releases/download/v${ETCD_BIN_VERSION}/etcd-v${ETCD_BIN_VERSION}-linux-amd64.tar.gz | \
              tar -xzf - -C /tmp  && \
    mv /tmp/etcd-v${ETCD_BIN_VERSION}-linux-amd64/etcd /usr/local/bin && \
    rm -fr /tmp/etcd-v${ETCD_BIN_VERSION}-linux-amd64* && \
    apt-get autoremove -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rabbitmq-plugins enable --offline autocluster \
      rabbitmq_consistent_hash_exchange \
      rabbitmq_federation \
      rabbitmq_federation_management \
      rabbitmq_mqtt \
      rabbitmq_shovel \
      rabbitmq_shovel_management \
      rabbitmq_stomp \
      rabbitmq_web_stomp

ADD rabbitmq-wrapper.sh /usr/local/bin/rabbitmq-wrapper.sh
