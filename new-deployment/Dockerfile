FROM 981144953497.dkr.ecr.ap-south-1.amazonaws.com/docker-node-express-boilerplate_app-stag:latest
COPY .env /home/nodejs/app
EXPOSE 5000
CMD ["pm2-runtime", "./config/pm2.json"]