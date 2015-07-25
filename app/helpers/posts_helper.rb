module PostsHelper
  include ActsAsTaggableOn::TagsHelper
  def available_tags
    @tags ||= Post.tag_counts_on(:tags)
  end
end
