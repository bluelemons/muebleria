require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  test "existing client" do
    john = clients :john
    put :update, dni: john.dni, client: {name: 'pepe'}
    updated_john = Client.find(john.id)
    assert updated_john.name == 'pepe'
  end

  test "unexisting client" do
    put :update, dni: '55555555', client: {name: 'jane'}
    last_client = Client.last
    assert last_client.name == 'jane'
    assert last_client.dni == '55555555'
  end

  test "should create unexisting client" do
    assert_difference 'Client.count' do
      put :update, dni: '35353535', client: {name: 'ceci'}
    end
  end
end
