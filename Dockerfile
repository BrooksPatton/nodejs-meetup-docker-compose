FROM node:8
RUN apt-get update && apt-get install -y vim
RUN useradd -mU ine
USER ine
WORKDIR /home/ine
RUN npm init -y
ADD api.key /home/ine
ADD mongo-redis.config /home/ine
RUN npm install screeps
RUN npx screeps init < api.key
RUN cat mongo-redis.config >> .screepsrc
ADD --chown=ine:ine mods.json /home/ine/
RUN mkdir mods
WORKDIR /home/ine/mods
RUN npm init -y
RUN npm install screepsmod-mongo
WORKDIR /home/ine
EXPOSE 21025
CMD ["npx", "screeps", "start"]

