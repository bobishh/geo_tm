require 'mongoid'

module GeoTM
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :role, type: String
    field :name, type: String
    field :token, type: String

    index token: 1, role: -1

    has_many :tasks, class_name: '::GeoTM::Task', inverse_of: :manager
    has_many :assigned_tasks, class_name: '::GeoTM::Task', inverse_of: :assignee
  end
end
