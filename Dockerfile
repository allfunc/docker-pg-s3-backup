ARG VERSION=${VERSION:-[VERSION]}

FROM alpine:3.19

ARG VERSION

# apk
COPY ./install-packages.sh /usr/local/bin/install-packages
RUN apk update && apk add bash bc \
  && INSTALL_VERSION=$VERSION INSTALL_TARGETPLATFORM=$TARGETPLATFORM install-packages \
  && rm /usr/local/bin/install-packages;

COPY ./docker/sbin /usr/local/sbin
ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]

ENV POSTGRES_HOST='' \
  POSTGRES_PORT=5432 \
  POSTGRES_USER=postgres \
  POSTGRES_PASSWORD=postgres \
  POSTGRES_DATABASE=postgres

CMD ["server"]
