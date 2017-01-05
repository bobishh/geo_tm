module GeoTM
  module SpecHelpers
    class << self
      def random_locations
        { pickup: random_point,
          delivery: random_point }
      end

      def random_point
        { lat: rand(180) - (89 + rand),
          lng: rand(360) - (179 + rand) }
      end
    end
  end
end
