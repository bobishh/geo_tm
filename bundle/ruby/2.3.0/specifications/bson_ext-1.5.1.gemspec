# -*- encoding: utf-8 -*-
# stub: bson_ext 1.5.1 ruby ext
# stub: ext/cbson/extconf.rb

Gem::Specification.new do |s|
  s.name = "bson_ext".freeze
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["ext".freeze]
  s.authors = ["Mike Dirolf".freeze]
  s.date = "2011-11-29"
  s.description = "C extensions to accelerate the Ruby BSON serialization. For more information about BSON, see http://bsonspec.org.  For information about MongoDB, see http://www.mongodb.org.".freeze
  s.email = "mongodb-dev@googlegroups.com".freeze
  s.extensions = ["ext/cbson/extconf.rb".freeze]
  s.files = ["ext/cbson/extconf.rb".freeze]
  s.homepage = "http://www.mongodb.org".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "C extensions for Ruby BSON.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version
end
