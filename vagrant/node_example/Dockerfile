FROM node:alpine
WORKDIR /code
ADD code /code
RUN npm install --production
EXPOSE 3000
CMD [ "node", "app.js" ]