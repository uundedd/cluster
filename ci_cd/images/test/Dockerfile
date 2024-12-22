ARG IMAGE_REGISTRY=hub.docker.com
ARG PNPM_VERSION=9

FROM ${IMAGE_REGISTRY}/library/cypress-included:13.8.1 

ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="${PATH}:${PNPM_HOME}"


RUN npm install -g pnpm@${PNPM_VERSION}

#install k6
WORKDIR /tmp
RUN wget https://github.com/grafana/k6/releases/download/v0.47.0/k6-v0.47.0-linux-amd64.deb
RUN dpkg -i k6-v0.47.0-linux-amd64.deb

RUN chown -R node:node /home

USER node

RUN pnpm config set store-dir /home/.pnpm-store

COPY --chown=node:node ./test/.pnpm-stor[e]/ /home/.pnpm-store/

RUN mkdir /home/test

WORKDIR /home/test

COPY --chown=node:node ./test/pnpm-lock.yaml .
COPY --chown=node:node .npmrc .

RUN pnpm fetch 

WORKDIR /home/node

ENV baseUrl=http://nginx

ENTRYPOINT ["/bin/sleep" , "infinity"]