ARG IMAGE_REGISTRY=hub.docker.com
ARG PNPM_VERSION=10

FROM ${IMAGE_REGISTRY}/library/typescript-node:18

RUN npm install -g pnpm@${PNPM_VERSION}
RUN npm install -g @nestjs/cli
RUN npm install -g @angular/cli
RUN git config --global http.sslVerify false

#install dependency postgresql
RUN apt-get update 
RUN apt-get install postgresql-client redis-tools -y
# install zstd for compression 
RUN apt-get install zstd

#access user node for make directory in home
RUN chown -R node:node /home

#install mc clinet for minio
USER node  

RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o $HOME/minio-binaries/mc

RUN chmod +x $HOME/minio-binaries/mc
ENV PATH=$PATH:$HOME/minio-binaries/


# COPY .git /home/.git
RUN mkdir /home/app