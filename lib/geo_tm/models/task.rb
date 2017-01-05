require 'mongoid'

module GeoTM
  class Task
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title, type: String
    field :description, type: String

    belongs_to :assignee,
               class_name: 'GeoTM::User',
               inverse_of: :assigned_tasks,
               optional: true

    belongs_to :manager,
               class_name: 'GeoTM::User',
               inverse_of: :tasks

    field :pickup, type: Array, default: [0, 0]
    field :delivery, type: Array, default: [0, 0]

    index({ pickup: '2d' }, min: -180, max: 180, background: true)

    field :state, type: String, default: 'new'
  end
end
