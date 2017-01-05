module GeoTM
  module Validators
    # helpers for validating location
    module Location
      def location_invalid?(location)
        !location_valid?(location)
      end

      def location_valid?(location)
        return false if location.nil?
        [:lat, :lng].reduce(true) do |acc, key|
          acc = location_error(key) if location[key].nil? || point_invalid?(location[key].to_f, key)
          acc
        end
      end

      private

      def location_error(key)
        model.errors.add(key, 'Wrong coordinates! -90 < lat < 90,'\
                              '-180 < lng < 180')
        false
      end

      def point_invalid?(value, key)
        !point_valid?(value, key)
      end

      def point_valid?(value, key)
        value >= degrees_limits(key)[:min] && value <= degrees_limits(key)[:max]
      end

      def degrees_limits(key)
        case key
        when :lat
          { min: -90, max: 90 }
        when :lng
          { min: -180, max: 180 }
        end
      end
    end
  end
end
