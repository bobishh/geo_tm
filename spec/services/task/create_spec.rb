require_relative '../../spec_helper'
require_relative '../../../lib/geo_tm/services/task/create.rb'

describe GeoTM::Task::Create do
  let(:token) { 'AAABBBCCC' }
  let(:wrong_token) { 'BBAACC' }

  let(:locations) do
    { pickup: { lat: 24.123123, lng: 23.4123123 },
      delivery: { lat: 24.12313, lng: 12.1223 } }
  end

  describe 'valid' do
    before do
      @user = GeoTM::User.create token: token,
                                 name: 'Supa User',
                                 role: 'manager'
      @task = GeoTM::Task::Create.(
        task: locations,
        token: token
      ).model
    end

    it 'persists valid' do
      @task.persisted?.must_equal true
    end

    it 'has "new" state' do
      @task.state.must_equal 'new'
    end

    it 'has no errors' do
      @task.valid?.must_equal true
    end
  end

  describe 'invalid' do
    before do
      @user = GeoTM::User.create token: wrong_token,
                                 name: 'Supa User',
                                 role: 'driver'
      @task = GeoTM::Task::Create.(
        task: locations,
        token: wrong_token
      ).model
    end

    it 'wont persist invalid' do
      @task.persisted?.must_equal false
    end
  end
end
