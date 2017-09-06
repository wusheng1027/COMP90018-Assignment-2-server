require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::UsersController, type: :controller do
    let!(:model) { create :user }
    let(:show_attr) { %w(id first_name last_name and username) }
    let(:invalid_model_attributes) { {first_name:nil} }

    it_behaves_like 'a resource controller'
end