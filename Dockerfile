FROM ruby:2.7.2-alpine
ENV BUNDLER_VERSION=2.1.4

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      tzdata \
      yarn

RUN gem install bundler -v 2.1.4

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle
COPY package.json yarn.lock ./
RUN yarn install --check-files
COPY . ./
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
