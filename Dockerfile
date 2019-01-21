# The version of Alpine to use for the final image
# This should match the version of Alpine that the `elixir:1.7.2-alpine` image uses
ARG ALPINE_VERSION=3.8

FROM elixir:1.7.2-alpine AS builder

ENV MIX_ENV=prod
ENV APP_NAME=teamcowboygraphql
ENV APP_VSN=0.1.0

WORKDIR /opt/app

RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
    build-base && \
  mix local.rebar --force && \
  mix local.hex --force

COPY . .

RUN echo ${PORT}
RUN echo ${SECRET_KEY_BASE}

RUN mix do deps.get, deps.compile, compile

RUN \
  mkdir -p /opt/built && \
  mix release --verbose && \
  cp _build/${MIX_ENV}/rel/${APP_NAME}/releases/${APP_VSN}/${APP_NAME}.tar.gz /opt/built && \
  cd /opt/built && \
  tar -xzvf ${APP_NAME}.tar.gz && \
  rm ${APP_NAME}.tar.gz

FROM alpine:${ALPINE_VERSION}

ENV APP_NAME=teamcowboygraphql

RUN apk update && \
    apk add --no-cache \
    bash \
    openssl-dev

ENV REPLACE_OS_VARS=true

WORKDIR /opt/app

COPY --from=builder /opt/built .

RUN echo ${PORT}
RUN echo ${SECRET_KEY_BASE}

CMD trap 'exit' INT; /opt/app/bin/${APP_NAME} foreground
  