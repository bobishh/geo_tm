require_relative '../../spec_helper'
require_relative '../../../lib/geo_tm/services/task/create.rb'

describe GeoTM::Task::Assign do
  let(:manager_token) { 'AAABBBCCC' }
  let(:driver_token) { 'BBAACC' }

  let(:locations) do
    { pickup: { lat: 24.123123, lng: 23.4123123 },
      delivery: { lat: 24.12313, lng: 12.1223 } }
  end

  before do
    @manager = GeoTM::User.create token: manager_token,
                                  name: 'Supa User',
                                  role: 'manager'
    @task_id = GeoTM::Task::Create.(
      task: locations,
      token: manager_token
    ).model.id
    @driver = GeoTM::User.create token: driver_token,
                                 name: 'Supa User',
                                 role: 'driver'
  end

  describe 'valid' do
    before do
      @task = GeoTM::Task::Assign.(token: driver_token, id: @task_id).model
    end
    it 'persists valid' do
      @task.state.must_equal 'assigned'
    end

    it 'has no errors' do
      @task.valid?.must_equal true
    end
  end

  describe 'invalid' do
    before do
      @task = GeoTM::Task::Assign.(token: manager_token, id: @task_id).model
    end

    it 'wont update invalid' do
      @task.state.must_equal 'new'
    end
  end
end
