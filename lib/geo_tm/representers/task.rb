require 'roar/json'

module GeoTM
  class Task
    class Representer < Representable::Decorator
      include Roar::JSON
      property :title
      property :description
      property :state
      property :pickup
      property :delivery
      property :manager, writeable: false
      property :assignee
    end
  end
end
