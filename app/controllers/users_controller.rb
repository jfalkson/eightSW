class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  
  
 # GET /users
  # GET /users.json
 ##extract the user name 
 


  def index
  ##include all things associated with user to 
  ##use a join instead of having an n+1 query
  ##maximize big O value
    @users = User.order(:name).includes(:things).all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  @username=User.find_by(name: params[:name])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @username = User.find_by(name: params[:name])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, 
        notice: "User #{@user.name} User was successfully created. Please login to use the site" }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
                format.html { redirect_to users_url, 
        notice: "User #{user.name}User was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email)
    end
end
