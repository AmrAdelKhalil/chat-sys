FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /chat_system
WORKDIR /chat_system

COPY Gemfile /chat_system/Gemfile
COPY Gemfile.lock /chat_system/Gemfile.lock

ENV BUNDLER_VERSION=2.0.1

RUN gem install bundler --version 2.0.1 && bundle install

COPY . /chat_system