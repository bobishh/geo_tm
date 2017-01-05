require_relative './basic'
require_relative '../../validators/location'

module GeoTM
  class Task
    # service for creating a task
    class Create < Basic
      include GeoTM::Validators::Location
      TASK_ATTRIBUTES = %i(pickup delivery)

      def model
        @model ||= ::GeoTM::Task.new
      end

      private

      def process
        return false unless params_valid? && manager_token?
        model.assign_attributes(task_attributes)
        model.save
      end

      def task_attributes
        locations.merge(manager: manager)
      end

      def locations
        { pickup: location_array(:pickup),
          delivery: location_array(:delivery) }
      end

      def location_array(key)
        hash = @params[:task][key]
        [hash[:lat].to_f, hash[:lng].to_f]
      end

      def params_valid?
        [:pickup, :delivery].reduce(true) do |acc, key|
          acc = false unless location_valid?(@params[:task][key])
          acc
        end
      end

      def manager_token?
        return true unless manager.nil?
        model.errors.add :manager, 'Provided token doesn\t belong to manager'
      end

      def manager
        ::GeoTM::User.where(token: token, role: 'manager').first
      end
    end
  end
end
