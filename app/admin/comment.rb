ActiveAdmin.register Comment, :as => "PostComment" do
  scope :pending
  scope :accepting
  scope :declining

  actions :all, except: [:new, :create, :edit]

  filter :post
  filter :content
  filter :created_at
  filter :status

  member_action :accept, method: :put do
    resource.accept!
    redirect_to resource_path, notice: "Accept!"
  end

  member_action :decline, method: :put do
    resource.decline!
    redirect_to resource_path, notice: "Decline!"
  end

  index do
    column :post
    column "Content", max_width: "100px" do |comment|
      comment.content
    end
    column :created_at
    column :status

    column "Modration" do |comment|
      res = ''
      case comment.status
      when Comment::PENDING
        res += link_to "Accept", accept_admin_post_comment_path(comment), method: :put
        res += " or "
        res += link_to "Decline", decline_admin_post_comment_path(comment), method: :put
      when Comment::ACCEPT
        res += link_to "Decline", decline_admin_post_comment_path(comment), method: :put
      when Comment::DECLINE
        res += link_to "Accept", accept_admin_post_comment_path(comment), method: :put
      end
      res.html_safe
    end

    actions
  end


end
