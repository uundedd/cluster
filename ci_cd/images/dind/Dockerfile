ARG IMAGE_REGISTRY=hub.docker.com
ARG PNPM_VERSION=9

FROM ${IMAGE_REGISTRY}/gitlab/docker:dind

RUN apk add nodejs --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --allow-untrusted

RUN apk add --update npm

ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="${PATH}:${PNPM_HOME}"

RUN npm install -g pnpm@${PNPM_VERSION}
RUN pnpm install -g @angular/cli@16
RUN pnpm install -g @nestjs/cli

