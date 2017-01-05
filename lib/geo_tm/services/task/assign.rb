require_relative './basic'

module GeoTM
  class Task
    class Assign < Basic
      def process
        return false unless driver_token? || wrong_model?
        model.assign_attributes(assignee: driver, state: 'assigned')
        model.save
      end

      def model
        @model ||= GeoTM::Task.find(@params[:id])
      end

      def wrong_model?
        model.nil? || model.state != 'new'
      end

      protected

      def driver_token?
        !driver.nil?
      end

      def driver
        ::GeoTM::User.where(token: token, role: 'driver').first
      end
    end
  end
end
