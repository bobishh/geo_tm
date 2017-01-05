require_relative '../models/task'

module GeoTM
  class Task
    class Nearest
      DEFAULT_DISTANCE = 1000

      def initialize(params)
        @params = params
      end

      def result
        Task::Representer.for_collection.prepare(tasks)
      end

      def tasks
        Task.where(state: 'new').near(point)
      end

      private

      def point
        [@params[:lng].to_f, @params[:lat].to_f, DEFAULT_DISTANCE]
      end
    end
  end
end
