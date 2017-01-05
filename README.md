# GeoTM task geo tracker

## Usage
``` docker-compose up ```
### generate demo data
``` docker-compose run web rake initialize_demo ```
### run specs
``` docker-compose run web rake test ```
### wipe demo data if needed
``` docker-compose run web rake wipe:(tasks|users|all) ```

Every request needs a token, except for the root request, to curl-test routes you must obtain token first.
Max distance for $near was set to 200km.


## Story
First tried full-throttle trailblazer approach but met a few issues and decided to stick with similar, but hand-made "operations" to save time.
'Business logic' moved to operations, models used to model data relations only.

## Resume
It was fun! But also as a result of such an exercise I feel that I suck at Mongo-related stuff :-)
Also not sure if using 'belongs to' relations is the best approach in sense of speed and etc.
Doubts everywhere ...
