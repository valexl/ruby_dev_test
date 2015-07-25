ActiveAdmin.register Post do

  filter :title
  filter :category
  filter :content
  filter :created_at
  filter :published

  index do
    column :title
    column :category do |post|
      link_to(post.category.title, [:admin, post.category]) if post.category.present?
    end
    column :content
    column :tag_list
    column :created_at
    column :updated_at
    column :published
    actions do |post|
      if post.published?
        link_to "Unpublish!", unpublish_admin_post_path(post), method: :put
      else
        link_to "Publish!", publish_admin_post_path(post)
      end
    end
  end

  member_action :publish, method: :get do
    @post_form = VAlexL::RubyDevTest::FormObject::PublishedPost.new(post: resource)
    render :publish
  end

  member_action :set_publish, method: :put do
    @post_form = VAlexL::RubyDevTest::FormObject::PublishedPost.new({post: resource}.merge(params[:v_alex_l_ruby_dev_test_form_object_published_post]))
    if @post_form.apply!
      redirect_to resource_path, notice: "Published!"
    else
      render :publish
    end
  end
  
  member_action :unpublish, method: :put do
    resource.unpublish!
    redirect_to resource_path, notice: "Unpublished!"
  end

  form partial: 'form'

  show do
    attributes_table do
      row :title
      row :category do |post|
        post.category
      end
      row :content
      row :tag_list
      row :published do |post|
        post.published? ? "Yes" : "No"
      end

      div do
        if post.published?
          link_to "Unpublish!", unpublish_admin_post_path(post), method: :put
        else
          link_to "Publish!", publish_admin_post_path(post)
        end
      end
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
