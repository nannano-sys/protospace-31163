class PrototypesController < ApplicationController

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototypes_params)
      if @prototype.save
        redirect_to root_path
      else
        render :new
      end
  end

  def show
    @prototype = Prototype.find(params[:id]) 
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == prototype.user.id 
      redirect_to root_path
    end
    @prototype = Prototype.find(params[:id])

  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototypes_params)
      if @prototype.save
        redirect_to  prototype_path(@prototype.id)
      else 
        render :edit
      end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

   def prototypes_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
   end

end

