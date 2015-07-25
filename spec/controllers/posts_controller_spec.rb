require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:valid_attributes) {
    FactoryGirl.build(:post).attributes.symbolize_keys.slice(:title, :parent_id)
  }

  let(:invalid_attributes) {
    {title: nil}
  }

  let(:valid_session) { {} }

  describe "GET #manage" do
    it "assigns all posts as @posts" do
      post = FactoryGirl.create(:post)
      get :manage, {}, valid_session
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET #show" do
    it "assigns the requested post as @post" do
      post = FactoryGirl.create(:post)
      get :show, {:id => post.to_param}, valid_session
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET #new" do
    it "assigns a new post as @post" do
      get :new, {}, valid_session
      expect(assigns(:post)).to be_a_new(post)
    end
  end

  describe "GET #edit" do
    it "assigns the requested post as @post" do
      post = FactoryGirl.create(:post)
      get :edit, {:id => post.to_param}, valid_session
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new post" do
        expect {
          post :create, {:post => valid_attributes}, valid_session
        }.to change(post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, {:post => valid_attributes}, valid_session
        expect(assigns(:post)).to be_a(post)
        expect(assigns(:post)).to be_persisted
      end

      it "redirects to the created post" do
        post :create, {:post => valid_attributes}, valid_session
        expect(response).to redirect_to(post.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        post :create, {:post => invalid_attributes}, valid_session
        expect(assigns(:post)).to be_a_new(post)
      end

      it "re-renders the 'new' template" do
        post :create, {:post => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "assigns the requested post as @post" do
        post = FactoryGirl.create(:post)
        put :update, {:id => post.to_param, :post => valid_attributes}, valid_session
        expect(assigns(:post)).to eq(post)
      end

      it "redirects to the post" do
        post = FactoryGirl.create(:post)
        put :update, {:id => post.to_param, :post => valid_attributes}, valid_session
        expect(response).to redirect_to(post)
      end
    end

    context "with invalid params" do
      it "assigns the post as @post" do
        post = FactoryGirl.create(:post)
        put :update, {:id => post.to_param, :post => invalid_attributes}, valid_session
        expect(assigns(:post)).to eq(post)
      end

      it "re-renders the 'edit' template" do
        post = FactoryGirl.create(:post)
        put :update, {:id => post.to_param, :post => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post = FactoryGirl.create(:post)
      expect {
        delete :destroy, {:id => post.to_param}, valid_session
      }.to change(post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = FactoryGirl.create(:post)
      delete :destroy, {:id => post.to_param}, valid_session
      expect(response).to redirect_to(posts_url)
    end
  end

end
