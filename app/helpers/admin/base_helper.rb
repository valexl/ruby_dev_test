module Admin::BaseHelper
  def display_categories
    sortable_tree @categories, :new_url => new_admin_category_path
  end

  def get_available_tags_for_post(post)
    available_tags  = ActsAsTaggableOn::Tag.all.collect {|t| [ t.name]}
    available_tags += post.tag_list.collect {|t| [t]} if post.tag_list.present?
    available_tags.uniq!
    available_tags
  end

end
