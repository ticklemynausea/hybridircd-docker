FROM alpine:3.7

ENV HYBRID_VERSION 8.2.24

ARG CONFIGURE_FLAGS="--prefix=/opt/hybrid --enable-epoll --enable-openssl"
ARG MAKE_FLAGS=""

RUN set -x \
    && adduser -S ircd \
    && addgroup -S ircd \
    && apk add --no-cache --virtual runtime-dependencies \
      su-exec \
      tini \
      build-base \
      openssl-dev \
      curl \
    && mkdir /hybrid-src && cd /hybrid-src \
    && curl -fsSL "https://datapacket.dl.sourceforge.net/project/ircd-hybrid/ircd-hybrid/ircd-hybrid-${HYBRID_VERSION}/ircd-hybrid-${HYBRID_VERSION}.tgz" -o hybrid.tgz \
    && tar xfz hybrid.tgz --strip-components=1 \
    && mkdir build && cd build \
    && ls \
    && ../configure $CONFIGURE_FLAGS \
    && make $MAKEFLAGS \
    && make install \
    && cd / && rm -rf /hybrid-src

COPY scripts/entrypoint.sh /
COPY scripts/startup-sequence/* /startup-sequence/

VOLUME /hybrid-data

EXPOSE 6667 6697

ENTRYPOINT ["/entrypoint.sh"]
