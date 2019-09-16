FROM node:10.16.0

LABEL MAINTAINER Michael Hueter <mthueter@gmail.com>

RUN npm install pm2@3.5.1 --global --quiet
# add local user for security
RUN groupadd -r nodejs \
  && useradd -m -r -g nodejs nodejs

USER nodejs

# copy local files into container, set working directory and user
RUN mkdir -p /home/nodejs/app
WORKDIR /home/nodejs/app
COPY . /home/nodejs/app
COPY .env /home/nodejs/app

RUN npm install --production --quiet

EXPOSE 5000

CMD ["pm2-runtime", "./config/pm2.json"]
