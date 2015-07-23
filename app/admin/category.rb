ActiveAdmin.register Category do

  
  controller do
    include TheSortableTreeController::Rebuild
  end
  
  config.filters = false
  config.paginate = false

  index do
    ol class: 'sortable_tree', 'data-rebuild_url' => rebuild_admin_categories_url, 'data-cookie_store' => :true  do
      display_categories
    end
  end

  show do
    render 'category_info'
  end
  
  form partial: 'form'

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
