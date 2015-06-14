FROM ruby:2.2.0

RUN apt-get update

# for postgres
RUN apt-get install -y libpq-dev

# node.js
RUN apt-get install -y nodejs

ENV dir code

RUN mkdir $dir

ADD . $dir

WORKDIR $dir

RUN bundle install
