class ReactionsController < ApplicationController
  before_action :authenticate_user!

  def user_reaction
    @user = current_user
    @post = Post.find(params[:post_id])
      reaction = Reaction.find_by(user_id: @user.id, post_id: @post.id)
      if reaction
        flash.now[:alert] = "You already reacted to this post"
      else
        @new_reaction = Reaction.new(user_id: @user.id, post_id: @post.id, kind: params[:kind])
        respond_to do |format|
          if @new_reaction.save!
            format.html { redirect_to post_path(@post), notice: "#{current_user.email} has stated that it #{@new_reaction.kind} the product" }
          else
            format.html { redirect_to post_path(@post), status: :unprocessable_entity }
          end
        end
      end
  end
  def post_with_reactions
    @reactions = current_user.reactions
    post_ids = @reactions.map(&:post_id)
    @posts = Post.where(id: post_ids)
  end
end
