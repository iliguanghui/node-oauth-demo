# syntax=docker/dockerfile:1.7-labs
FROM node:22.1-bullseye
RUN sed -i 's@http://deb.debian.org@https://mirrors.aliyun.com@g' /etc/apt/sources.list
RUN apt update && apt -y install tini && rm -rf /var/lib/apt/lists/*
USER node
WORKDIR /app
RUN npm config set registry https://registry.npmmirror.com
COPY --chown=node:node package.json ./
RUN npm install
COPY --chown=node:node ./ ./
EXPOSE 80
CMD ["tini", "-e", "143", "--", "node", "index.js"]
