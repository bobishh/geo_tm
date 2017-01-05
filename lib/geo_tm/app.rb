require 'sinatra/base'
require 'sinatra/json'

require_relative 'app/helpers'
require_relative 'models/task'
require_relative 'representers/task.rb'
require_relative 'app/helpers'
require_relative 'services/task/create'
require_relative 'services/task/assign'
require_relative 'services/task/complete'
require_relative 'services/task/near'

module GeoTM
  class App < Sinatra::Base
    include Helpers

    configure do
      Mongoid.load!('config/mongoid.yml', settings.environment)
      set :server, :thin
    end

    before do
      pass unless request.path_info != '' && invalid_token?
      status 403
    end

    def invalid_token?
      return true if payload[:token].nil?
      GeoTM::User.where(token: payload[:token]).first.nil?
    end

    get '/tasks/near' do
      op = Task::Near.(payload) do |op|
        status 200
        return json Task::Representer.for_collection.prepare(op.results)
      end
      status 422
      json op.model.errors
    end

    get '/tasks' do
      json Task::Representer.for_collection.prepare(GeoTM::Task.all)
    end

    post '/tasks' do
      op = Task::Create.(payload) do |op|
        status 201
        return json Task::Representer.new(op.model)
      end
      status 422
      json op.model.errors
    end

    patch '/tasks/:id/complete' do
      op = Task::Complete.(payload) do |op|
        status 202
        return json Task::Representer.new(op.model)
      end
      status 422
      json op.model.errors
    end

    patch '/tasks/:id/assign' do
      op = Task::Assign.(payload) do |op|
        status 202
        return json Task::Representer.new(op.model)
      end
      status 422
      json op.model.errors
    end

    get '/tasks/:id' do
      task = Task.find(payload)
      json Task::Representer.new(task)
    end

    get '/' do
      json  users: GeoTM::User.all, tasks_count: GeoTM::Task.count
    end
  end
end
