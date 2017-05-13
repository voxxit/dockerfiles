FROM python:3.6.1-slim

RUN pip install --no-cache awscli && rm -rf $HOME/.cache

RUN apt-get update \
  && apt-get -y install --no-install-recommends wget pv \
  && wget -O /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
  && chmod a+x /usr/local/bin/jq \
  && apt-get -y remove --purge wget \
  && apt-get -y autoremove --purge \
  && rm -rf /var/lib/apt/lists/*

ENV S3_INVENTORY_SOURCE_BUCKET=""
ENV S3_INVENTORY_NAME=""
ENV S3_INVENTORY_DESTINATION_BUCKET=""
ENV S3_INVENTORY_DESTINATION_PREFIX=""

COPY docker-entrypoint.sh /

VOLUME ["/out"]

ENTRYPOINT ["/docker-entrypoint.sh"]
