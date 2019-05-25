FROM ruby:2.3.1

RUN sed -i '/jessie-updates/d' /etc/apt/sources.list

RUN apt-get update -qq && apt-get install -y --force-yes build-essential libpq-dev mysql-client vim nodejs

RUN mkdir -p /var/www/plantcare

ENV RAILS_ROOT /var/www/plantcare

RUN mkdir -p $RAILS_ROOT/tmp/pids

WORKDIR $RAILS_ROOT

COPY ./Gemfile Gemfile

COPY ./Gemfile.lock Gemfile.lock

ENV BUNDLER_VERSION 2.0.1

RUN gem install bundler

RUN bundle install

COPY ./config/puma.rb config/puma.rb

COPY . .

EXPOSE 3001

CMD bundle exec puma -C config/puma.rb
