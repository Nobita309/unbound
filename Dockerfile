FROM alpine:latest

RUN apk add --no-cache unbound iproute2 ca-certificates curl tini \
  && update-ca-certificates \
  && mkdir -p /var/lib/unbound \
  && chown -R unbound:unbound /var/lib/unbound

RUN wget -O /var/lib/unbound/root.hints https://www.internic.net/domain/named.cache && unbound-anchor -a /var/lib/unbound/root.key || true

CMD ["sh", "/etc/unbound/unbound.conf.d/unbound.sh"]
