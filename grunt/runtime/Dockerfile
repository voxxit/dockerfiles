FROM voxxit/grunt:latest

WORKDIR /app

ONBUILD ADD package.json /app/
ONBUILD RUN npm install
ONBUILD ADD bower.json /app/
ONBUILD RUN bower install --allow-root
ONBUILD ADD . /app

CMD [ "grunt" ]
