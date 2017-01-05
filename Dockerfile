FROM ruby:2.3-alpine

ENV APP_HOME /var/project
ENV THIN_PORT "4242"
WORKDIR $APP_HOME

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base git curl" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-json yaml"

RUN apk --update --upgrade add $BUILD_PACKAGES $DEV_PACKAGES && \
  gem install -N bundler

ENV RACK_ENV production

ADD Gemfile* $APP_HOME/

RUN bundle install --without development

ADD ./* $APP_HOME/

RUN chmod +x $APP_HOME/run.sh

EXPOSE $THIN_PORT

CMD sh $APP_HOME/run.sh
