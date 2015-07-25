require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  login_user

  let(:valid_attributes) {
    FactoryGirl.build(:post).attributes.symbolize_keys.slice(:title, :parent_id)
  }

  let(:invalid_attributes) {
    {title: nil}
  }

  let(:valid_session) { {} }


  describe "GET #show" do
    it "assigns the requested post as @post" do
      post = FactoryGirl.create(:post)
      get :show, {:id => post.to_param}, valid_session
      expect(assigns(:post)).to eq(post)
    end
  end
end
