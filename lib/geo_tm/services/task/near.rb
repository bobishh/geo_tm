require_relative '../../models/task'
require_relative '../../representers/task'
require_relative '../../validators/location'

module GeoTM
  class Task
    class Near < Basic
      include GeoTM::Validators::Location
      MAX_DISTANCE = 200.fdiv(111) # 200 kilometers from location
      # http://stackoverflow.com/questions/7848634/maximum-distance-with-mongoids-model-near-method

      def results
        return [] unless @successful
        tasks
      end

      def model
        GeoTM::Task.new
      end

      private

      def process
        return false if wrong_token? || location_invalid?(location)
        true
      end

      def location
        @params.symbolize_keys.slice(:lat, :lng)
      end

      def tasks
        @tasks ||= Task.where(state: 'new').near(location_criteria)
      end

      def location_criteria
        { pickup: [@params[:lat].to_f, @params[:lng].to_f, MAX_DISTANCE] }
      end

      def wrong_token?
        GeoTM::User.where(token: token).count.zero?
      end
    end
  end
end
