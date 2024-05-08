# syntax=docker/dockerfile:1.7-labs
FROM node:22.1-bullseye
RUN sed -i 's@http://deb.debian.org@https://mirrors.aliyun.com@g' /etc/apt/sources.list
RUN apt update && apt -y install tini && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --chown=node:node ./ ./
RUN npm config set registry https://registry.npmmirror.com
RUN npm install
USER node
EXPOSE 80
CMD ["tini", "-e", "143", "--", "node", "index.js"]
