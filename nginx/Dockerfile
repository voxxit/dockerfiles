FROM uggedal/alpine-3.0

MAINTAINER Joshua Delsman <@voxxit>

RUN echo "http://repos.lax-noc.com/alpine/v3.0/main" > /etc/apk/repositories && \
    apk update && \
    apk add nginx

CMD ["sh"]
