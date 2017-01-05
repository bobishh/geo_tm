require_relative '../../models/task'
require_relative '../../models/user'

module GeoTM
  class Task
    class Basic
      def self.call(params, &block)
        new(params).run(&block)
      end

      def initialize(params)
        @params = params
      end

      def process
        raise NotImplementedError, '#process must be implemented in child'
      end

      def model
        raise NotImplementedError, '#model must be implemented in child'
      end

      def run
        @successful = process
        return yield(self) if @successful && block_given?
        self
      end

      private

      def token
        @token ||= @params[:token]
      end
    end
  end
end
