module Admin::BaseHelper
  def display_categories
    sortable_tree @categories, :new_url => new_admin_category_path
  end

end
