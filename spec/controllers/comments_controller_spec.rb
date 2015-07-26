require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:valid_attributes) {
    valid_product_type = FactoryGirl.build(:comment)
    valid_product_type.attributes.except('id', 'created_at', 'updated_at')
  }

  let(:invalid_attributes) {
    {'context' => nil}
  }

  describe "POST #create" do
    describe 'regestrated user' do
      login_user

      it "creates a new Comment with valid params" do
        expect {
          post :create, :comment => valid_attributes, format: 'js'
        }.to change(Comment, :count).by(1)
      end
    end
  end
end
