FROM centos:7 AS builder
RUN yum install -y wget curl
RUN mkdir -p /opt/kafka
RUN curl -o /opt/kafka.tgz https://apache-mirror.rbc.ru/pub/apache/kafka/2.4.0/kafka_2.12-2.4.0.tgz
WORKDIR /opt
RUN tar xzf kafka.tgz -C /opt


FROM centos:7
RUN yum install -y epel-release && yum install -y java-1.8.0-openjdk.x86_64 && mkdir -p /opt/kafka
WORKDIR /opt/kafka
COPY --from=builder /opt/kafka/kafka_2.12-2.4.0/ .
EXPOSE 9092

ENTRYPOINT ["/entrypoint.sh"]
