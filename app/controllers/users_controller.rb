class UsersController < ApplicationController
  def index; end

  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username}"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
  end

  def destroy

  end

  def basket
    @user = current_user
    @ebooks = ebooks_with_quantities(@user)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    return if @user == current_user

    flash[:danger] = 'You can only edit your own accout'
    redirect_to root_path
  end

  def require_admin
    return unless logged_in? && !current_user.admin?

    flash[:danger] = 'Only admin can do that.'
    redirect_to root_path
  end

  def ebooks_with_quantities(user)
    ebooks = user.ebooks
    ebooks_with_quantities = []
    ebooks.each do |e|
      quantity = UserEbook.where(user_id: user.id, ebook_id: e.id).first.quantity
      ebooks_with_quantities << e.serializable_hash.merge('quantity': quantity)
    end
    ebooks_with_quantities
  end
end
