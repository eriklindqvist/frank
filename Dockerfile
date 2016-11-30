#https://blog.codeship.com/build-minimal-docker-container-ruby-apps/

FROM alpine:edge
MAINTAINER Erik Lindqvist <erikjo82@gmail.com>

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add linux-headers bash curl-dev openssh-client build-base git && \
    apk add ruby ruby-dev ruby-io-console ruby-bundler && \
    apk add tzdata && \
    cp /usr/share/zoneinfo/Europe/Stockholm /etc/localtime && \
    echo "Europe/Stockholm" > /etc/timezone && \
    rm -rf /var/cache/apk/*

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN bundle install --no-color

COPY . /usr/app

EXPOSE 4005
