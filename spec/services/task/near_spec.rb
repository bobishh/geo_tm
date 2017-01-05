require_relative '../../spec_helper'
require_relative '../../../lib/geo_tm/services/task/near.rb'

describe GeoTM::Task::Near do
  let(:manager_token) { 'AAABBBCCC' }
  let(:driver_token) { 'BBAACC' }

  before do
    @manager = GeoTM::User.create token: manager_token,
                               name: 'Supa User',
                               role: 'manager'
    @driver = GeoTM::User.create token: driver_token,
                                 name: 'Supa Driver',
                                 role: 'driver'
    GeoTM::Task.create_indexes
    42.times do
      GeoTM::Task::Create.(
        token: manager_token,
        task: GeoTM::SpecHelpers.random_locations
      )
    end
    @points = GeoTM::Task.first.pickup
  end

  describe 'valid' do
    before do
      op = GeoTM::Task::Near.(token: driver_token, lat: @points[0], lng: @points[1])
      @results = op.results
    end

    it 'returns some tasks' do
      @results.count.must_be :>, 0
    end

    it 'filters out some tasks' do
      @results.count.must_be :<, 42
    end

    it 'returns only new tasks' do
      @results
    end
  end
end
