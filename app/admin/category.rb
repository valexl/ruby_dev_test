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
    attributes_table do
      row :title
      row :parent do |post|
        post.parent
      end
    end
  end
  
  form partial: 'form'

end
