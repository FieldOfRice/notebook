FROM quay.io/jupyter/minimal-notebook
ARG BUILD_DATE
ARG BUILD_VERSION
USER root
LABEL org.opencontainers.image.authors="thor42@my-private-garden.com" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.version=$BUILD_VERSION \
      org.opencontainers.image.description="my-private-garden.com jupyterlab jdk-17.0.2"
COPY ./files/rclone_install.sh /tmp
COPY ./files/openjdk-17.0.2_linux-x64_bin.tar.gz /tmp
COPY ./files/.bash_aliases /home/jovyan/
COPY ./files/notification.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/
COPY ./files/themes.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/
COPY ./files/rclone.sh /home/jovyan/

RUN id
RUN mkdir .config; cd .config; ln -s /tmp/notebook/rclone
RUN cd /home/jovyan; mv work work_off; ln -s /tmp/notebook work
RUN cd /opt; tar xzf /tmp/openjdk-17.0.2_linux-x64_bin.tar.gz; rm /tmp/openjdk-17.0.2_linux-x64_bin.tar.gz
RUN pip install jupyterlab_execute_time jupyter_ai ollama langchain-ollama pipdeptree -q
RUN apt update; apt install -y fuse3
RUN /tmp/rclone_install.sh
RUN mkdir -p /mnt/gdrive; chmod a+rwx /mnt /mnt/gdrive
RUN chown -R jovyan:users /home/jovyan/.jupyter/lab

USER jovyan

# use "curl https://rclone.org/install.sh" to get ./files/rclone_install.sh
# use "https://jdk.java.net/archive/" to get "Linux/x64" ./files/openjdk-17.0.2_linux-x64_bin.tar.gz
# use "pipdeptree -r -p dask" to get dependecy tree

