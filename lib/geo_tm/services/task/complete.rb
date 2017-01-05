require_relative './assign'

module GeoTM
  class Task
    class Complete < Assign
      def process
        return false unless assigned_driver? || wrong_model?
        model.update state: 'done'
      end

      def assigned_driver?
        return false if model.nil?
        model.assignee == driver
      end

      def wrong_model?
        model.state != 'assigned'
      end
    end
  end
end
