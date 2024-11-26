ARG IMAGE_REGISTRY=hub.docker.com

FROM ${IMAGE_REGISTRY}/library/routingmanager:stable

RUN echo "fs.inotify.max_user_watches=524288" | tee -a /etc/sysctl.conf
RUN sysctl -p