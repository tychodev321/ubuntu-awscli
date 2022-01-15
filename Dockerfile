FROM registry.access.redhat.com/ubi8/ubi-minimal:8.4
# FROM redhat/ubi8/ubi-minimal:8.4

LABEL maintainer=""

ENV AWSCLI_VERSION=2.0.30
ENV AWSCLI_URL=https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip

# MicroDNF is recommended over YUM for Building Container Images
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN microdnf update -y \
    && microdnf install -y unzip \
    && microdnf clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

# Download and install AWS CLI
RUN curl ${AWSCLI_URL} -o "awscliv2.zip" \ 
    && unzip awscliv2.zip \
    && ./aws/install -i /usr/local -b /usr/local/bin -u \
    && rm  -rf awscliv2.zip awscliv2

RUN aws --version

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
