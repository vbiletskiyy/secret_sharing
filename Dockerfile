FROM ruby:3.1.2

WORKDIR /usr/src/secret_sharing

COPY . .
RUN bundle install
