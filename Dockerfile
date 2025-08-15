FROM quay.io/jupyter/minimal-notebook@sha256:23c62f4ff7988996eb5271748a341adcecf099f85075d158e38619b3eddc4d62
# the above image seems from 2025-06-02T07:43:42
ARG BUILD_DATE
ARG BUILD_VERSION
LABEL org.opencontainers.image.authors="thor42@my-private-garden.com" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.version=$BUILD_VERSION \
      org.opencontainers.image.description="my-private-garden.com jupyterlab openjdk-17-jdk"
USER root
RUN apt-get update && apt-get install -y --no-install-recommends fuse3 openjdk-17-jdk && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir -q jupyterlab_execute_time jupyter_ai ollama langchain-ollama pipdeptree

# using static rclone version
COPY ./files/rclone_install.sh /tmp
RUN /tmp/rclone_install.sh && rm /tmp/rclone_install.sh && \
    mkdir -p /mnt/gdrive && chmod a+rwx /mnt /mnt/gdrive

USER jovyan
WORKDIR /home/jovyan
ADD ./files/config.tar .
RUN mkdir -p .cache .config && ln -s /tmp/notebook/rclone .config/rclone && \
    mv work work_off && ln -s /tmp/notebook work

# use "curl https://rclone.org/install.sh" to get ./files/rclone_install.sh
# use "https://jdk.java.net/archive/" to get "Linux/x64" ./files/openjdk-17.0.2_linux-x64_bin.tar.gz
# use "pipdeptree -r -p dask" to get dependecy tree
# use "docker inspect --format='{{index .RepoDigests 0}}' quay.io/jupyter/minimal-notebook:latest" to pin base image
# it's already using "HEALTHCHECK --interval=3s --timeout=1s --start-period=3s --retries=3 CMD /etc/jupyter/docker_healthcheck.py || exit 1" from base-notebook

