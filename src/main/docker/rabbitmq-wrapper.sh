#!/bin/bash

set -eu

SHAREDDIR="${MESOS_SANDBOX}/rabbitmq-data/shared"
export HOSTNAME="${TASK_NAME}.${FRAMEWORK_HOST}"
export ETCD_HOST=${HOSTNAME}
export RUNNING_UNDER_SYSTEMD=true
export RABBITMQ_NODENAME="rabbitmq@${HOSTNAME}"
export RABBITMQ_USE_LONGNAME=true
export RABBITMQ_SASL_LOG="-"
export RABBITMQ_LOGS="-"
export RABBITMQ_CONFIG_FILE="${MESOS_SANDBOX}/rabbitmq"
export RABBITMQ_HIGH_MEMORY_WATERMARK=128MiB

# to shell
if [ "x${RABBITMQ_CFG_ADVANCED_URL}" != "x" ]
then
ADVANCED_FILE=$(basename "${RABBITMQ_CFG_ADVANCED_URL}")
[ "x${ADVANCED_FILE}" = "x" ] && echo "ADVANCED_FILE is empty" && exit 1
[ "${ADVANCED_FILE}" != "rabbitmq.advanced" ] && \
               mv "${MESOS_SANDBOX}/${ADVANCED_FILE}" "${MESOS_SANDBOX}/rabbitmq.advanced.config"
export ADVANCED_CONFIG_FILE="${MESOS_SANDBOX}/rabbitmq.advanced"
fi

export RABBITMQ_MNESIA_BASE="${MESOS_SANDBOX}/rabbitmq-data/mnesia"

load_shared_env() {
  [ -f "${HOME}/.erlang.cookie" ] || {
    cp -p "${SHAREDDIR}/.erlang.cookie" "${HOME}/.erlang.cookie"
  }
  [ "x${TASK_MEM}" != "x" ] &&
      RABBITMQ_HIGH_MEMORY_WATERMARK=$(awk -v lim="$TASK_MEM" 'BEGIN { printf "%.0f\n", lim * 0.4 * 1024 * 1024; exit }')
}
case "$1" in
  *rabbitmq*)
      load_shared_env
      "${MESOS_SANDBOX}/bootstrap"
      exec gosu rabbitmq "$@"
      ;;
  "init")
      [ -f  "${SHAREDDIR}/.init_done" ] || {
        mkdir -p "${SHAREDDIR}" "${RABBITMQ_MNESIA_BASE}"
        mv "${MESOS_SANDBOX}/.erlang.cookie" "${SHAREDDIR}/.erlang.cookie"
        chmod 0600 "${SHAREDDIR}/.erlang.cookie"
        chown -R rabbitmq:rabbitmq "${SHAREDDIR}" "${RABBITMQ_MNESIA_BASE}"
        touch "${SHAREDDIR}/.init_done"
      }
      ;;
  *)
      echo "unknown operation"
      exit 1
      ;;
esac
