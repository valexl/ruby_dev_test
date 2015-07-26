class CommentsController < ApplicationController
  def create
    @commentation = VAlexL::RubyDevTest::FormObject::Commentation.new comment_params

    respond_to do |format|
      if @commentation.save
        format.js
      else
        format.js { render :error}
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :post_id, :captcha).merge(user_id: current_user.try(:id))
    end
end
