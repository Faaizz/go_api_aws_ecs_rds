# Base image
FROM node:16-alpine

WORKDIR /usr/src

COPY ./web .

RUN npm install

RUN npm run build

# Command to run on container upon start
CMD [ "/usr/local/bin/npm", "run", "start" ]
