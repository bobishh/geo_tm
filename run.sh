#!/bin/sh
bundle check

if [ $? -ne 0 ]
  then bundle install --retry=5
  else bundle exec rackup -s thin -p $THIN_PORT -o 0.0.0.0
fi
