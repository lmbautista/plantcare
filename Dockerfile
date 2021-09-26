FROM ruby:2.7.4

RUN sed -i '/jessie-updates/d' /etc/apt/sources.list

RUN apt-get update -qq && apt-get install -y --force-yes build-essential libpq-dev default-mysql-client vim nodejs

RUN mkdir -p /var/www/plantcare

ENV RAILS_ROOT /var/www/plantcare

RUN mkdir -p $RAILS_ROOT/tmp/pids

WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

COPY . /var/www/plantcare/

ENV BUNDLER_VERSION 2.0.1

RUN gem install bundler -v '2.0.1'

RUN bundle install

EXPOSE 8080

ENTRYPOINT ["bundle", "exec"]
CMD ["puma", "-C", "config/puma.rb"]
