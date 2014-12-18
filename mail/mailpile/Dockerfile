FROM voxxit/base:alpine

MAINTAINER Joshua Delsman <j (at) srv.im>

ENV MAILPILE_HOME /usr/share/Mailpile

RUN apk update \
  && apk add build-base py-pip libxml2-dev libxslt-dev git gnupg openssl python \
  && git clone https://github.com/mailpile/Mailpile.git /Mailpile \
  && pip install -r /Mailpile/requirements.txt \
  && /Mailpile/mp setup \
  && apk del build-base git

EXPOSE 33411

ENTRYPOINT [ "/Mailpile/mp" ]

CMD [ "--www=0.0.0.0:33411", "--wait" ]
