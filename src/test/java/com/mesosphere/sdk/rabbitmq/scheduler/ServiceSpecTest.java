package com.mesosphere.sdk.rabbitmq.scheduler;

import com.mesosphere.sdk.testing.BaseServiceSpecTest;
import org.junit.Test;

public class ServiceSpecTest extends BaseServiceSpecTest {

    public ServiceSpecTest() {
        super(
                "EXECUTOR_URI", "",
                "LIBMESOS_URI", "",
                "PORT_API", "8080",
                "FRAMEWORK_NAME", "rabbitmq",

                "RABBITMQ_RES_COUNT", "2",
                "RABBITMQ_RES_CPUS", "0.1",
                "RABBITMQ_RES_MEM", "512",
                "RABBITMQ_RES_DISK", "5000",
                "RABBITMQ_RES_DISK_TYPE", "ROOT",
                "RABBITMQ_RES_DOCKER_IMAGE", "sheepkiller/dcos-rabbitmq",
                "RABBITMQ_CFG_NODE_AMQP_PORT", "5672",
                "RABBITMQ_CFG_NODE_DIST_PORT", "25672",
                "RABBITMQ_CFG_MGMT_PORT", "15672"
             );
    }

    @Test
    public void testYmlBase() throws Exception {
        testYaml("svc.yml");
    }
}
