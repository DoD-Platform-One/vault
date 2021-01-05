#######  Global Stage ARGs
ARG BASE_REGISTRY=registry1.dsop.io
ARG BASE_IMAGE=ironbank/redhat/ubi/ubi8
ARG BASE_TAG=8.3

ARG UBI_IMAGE=${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}


# Multi-stage builder to avoid polluting users environment with wrong
# architecture binaries.  Since this binary is used in an alpine container,
# we're explicitly compiling for 'linux/amd64'
ARG VERSION=1.15.3

ARG CGO_ENABLED=0
ARG BUILD_TAGS



# RUN make bootstrap \
#   && CGO_ENABLED=$CGO_ENABLED BUILD_TAGS='$BUILD_TAGS' VAULT_DEV_BUILD=1 XC_OSARCH='linux/amd64' sh -c "'./scripts/build.sh'"

# Docker Image

FROM ${UBI_IMAGE} AS base

# Create a vault user and group first so the IDs get set the same way,
# even as the rest of this may change over time.
RUN groupadd vault && \
    useradd vault -g vault

WORKDIR /opt
# Set up certificates, our base tools, and pull latest Vault enterprise binaries and unzip them
RUN yum install ca-certificates wget libcap unzip tzdata -y \
    && wget https://releases.hashicorp.com/vault/${VAULT_VERSION}+ent.hsm/vault_${VAULT_VERSION}+ent.hsm_linux_amd64.zip \
    && mkdir -p /tmp/binaries \
    && unzip vault_${VAULT_VERSION}+ent.hsm_linux_amd64.zip -d /tmp/binaries \ 
    && cp /tmp/binaries/vault /bin/vault \
    && yum install http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/compat-openssl10-1.0.2o-3.el8.x86_64.rpm --nogpgcheck -y \
    && yum install https://s3.amazonaws.com/cloudhsmv2-software/CloudHsmClient/EL8/cloudhsm-client-latest.el8.x86_64.rpm --nogpgcheck -y \
    && yum install https://s3.amazonaws.com/cloudhsmv2-software/CloudHsmClient/EL8/cloudhsm-client-pkcs11-latest.el8.x86_64.rpm --nogpgcheck -y    

COPY CA.crt /opt/cloudhsm/etc/

ARG HSM_IP="10.122.8.27"

RUN /opt/cloudhsm/bin/configure -a ${HSM_IP} 

# /vault/logs is made available to use as a location to store audit logs, if
# desired; /vault/file is made available to use as a location with the file
# storage backend, if desired; the server will be started with /vault/config as
# the configuration directory so you can add additional config files in that
# location.
RUN mkdir -p /vault/logs && \
    mkdir -p /vault/file && \
    mkdir -p /vault/config && \
    chown -R vault:vault /vault

# Expose the logs directory as a volume since there's potentially long-running
# state in there
VOLUME /vault/logs

# Expose the file directory as a volume since there's potentially long-running
# state in there
VOLUME /vault/file

# 8200/tcp is the primary interface that applications use to interact with
# Vault.
EXPOSE 8200

# The entry point script uses dumb-init as the top-level process to reap any
# zombie processes created by Vault sub-processes.
#
# For production derivatives of this container, you should add the IPC_LOCK
# capability so that Vault can mlock memory.

RUN mkdir -p /tmp/source \
    && curl -Lo /tmp/source/vault.tar.gz https://github.com/hashicorp/vault/archive/v${VAULT_VERSION}.tar.gz \
    && tar -xzf /tmp/source/vault.tar.gz -C /tmp/source --strip-components=1


# Convert entrypoint to run on UBI8
# removes dumb-init
# may break openshift deployments
RUN cp /tmp/source/scripts/docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /usr/local/bin/docker-entrypoint.sh \
    && sed -i 's/^#\!.*/#\!\/bin\/sh/' /usr/local/bin/docker-entrypoint.sh \
    && sed -i 's/su-exec vault/vault/g' /usr/local/bin/docker-entrypoint.sh \
    && rm -rf /tmp/*


ENTRYPOINT ["docker-entrypoint.sh"]

# By default you'll get a single-node development server that stores everything
# in RAM and bootstraps itself. Don't use this configuration for production.
CMD ["server", "-dev"]