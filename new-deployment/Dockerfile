FROM docker-node-express-boilerplate_app-stag
COPY .env /home/nodejs/app
EXPOSE 5000
CMD ["pm2-runtime", "./config/pm2.json"]