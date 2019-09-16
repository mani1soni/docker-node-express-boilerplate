FROM docker-node-express-boilerplate_app-stag
COPY .env /app/
EXPOSE 9090
CMD npm run start:$NODE_ENV && pm2 logs all