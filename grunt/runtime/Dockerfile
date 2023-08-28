FROM voxxit/grunt:latest

WORKDIR /app

ONBUILD COPY package.json /app/
ONBUILD RUN npm install
ONBUILD COPY bower.json /app/
ONBUILD RUN bower install --allow-root
ONBUILD COPY . /app

CMD [ "grunt" ]
