require_relative '../../spec_helper'
require_relative '../../../lib/geo_tm/services/task/complete.rb'

describe GeoTM::Task::Complete do
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
    @task = GeoTM::Task::Assign.(token: driver_token, id: @task_id).model
  end

  describe 'run operation' do
    it 'finishes task by valid' do
      @task = GeoTM::Task::Complete.(token: driver_token, id: @task_id).model
      @task.state.must_equal 'done'
    end

    it 'can\'t be done by manager' do
      @task = GeoTM::Task::Complete.(token: manager_token, id: @task_id).model
      @task.state.must_equal 'assigned'
    end
  end
end
