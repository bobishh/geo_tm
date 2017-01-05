# users_test.rb
require File.expand_path '../../spec_helper.rb', __FILE__

# User controller tests
include Rack::Test::Methods

def app
  GeoTM::App
end

describe 'Tasks controller' do
  let(:manager_token) { 'IAMMANAGERBELEIVEME' }
  let(:driver_token) { 'DOUGH!' }

  before(:all) do
    @manager = ::GeoTM::User.create role: 'manager',
                                    name: 'Homer',
                                    token: manager_token
    @driver = ::GeoTM::User.create role: 'driver',
                                   name: 'Homer',
                                   token: driver_token
  end

  describe 'PATCH /tasks/:id/assign' do
    before do
      @task = ::GeoTM::Task::Create.(
        task: GeoTM::SpecHelpers.random_locations,
        token: manager_token
      ).model
      patch("/tasks/#{@task.id}/assign",
            { token: driver_token }, CONTENT_TYPE: 'application/json')
    end

    it 'assigns task to a driver' do
      last_response.status.must_equal 202
    end

    it 'changes state to assigned' do
      last_response.body.must_include 'assigned'
    end

    describe 'PATCH /tasks/:id/complete' do
      it 'changes state to "done"' do
        patch("/tasks/#{@task.id}/complete",
              { token: driver_token }, CONTENT_TYPE: 'application/json')
        last_response.status.must_equal 202
      end

      it 'can\'t be done by manager' do
        patch("/tasks/#{@task.id}/complete",
              { token: manager_token }, CONTENT_TYPE: 'application/json')
        last_response.status.must_equal 422
      end
    end
  end

  describe 'GET /tasks/near' do
    before do
      GeoTM::Task.create_indexes
      42.times do
        GeoTM::Task::Create.(
          token: manager_token,
          task: GeoTM::SpecHelpers.random_locations
        )
      end
      points = GeoTM::Task.first.pickup
      get '/tasks/near', { token: driver_token,
                           lat: points[0],
                           lng: points[1] },
          CONTENT_TYPE: 'application/json'
    end

    it 'returns status 200' do
      last_response.status.must_equal 200
    end

    it 'returns list of tasks with "new" state' do
      last_response.body.wont_include('assigned')
      last_response.body.wont_include('done')
    end

    it 'filters out some tasks' do
      results = JSON.parse(last_response.body)
      results.count.must_be :<, 42
    end

    it 'returns at least one point' do
      results = JSON.parse(last_response.body)
      results.count.must_be :>, 0
    end
  end

  describe 'POST /tasks' do
    describe 'valid' do
      it 'returns task in case of success' do
        post('/tasks',
             { task: GeoTM::SpecHelpers.random_locations,
               token: manager_token }, CONTENT_TYPE: 'application/json')
        last_response.status.must_equal 201
      end
    end

    describe 'invalid' do
      it 'returns 422 for unsuccessful request' do
        post('/tasks',
             { task: GeoTM::SpecHelpers.random_locations,
               token: driver_token }, CONTENT_TYPE: 'application/json')
        last_response.status.must_equal 422
      end
    end
  end
end
