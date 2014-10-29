class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index

  	
  	params[:start].nil? ? @start = 0 : @start = params[:start].to_i
  	@num_display = 20

  	@lines = Line.first_lines.ranked.offset(@start).limit(@num_display)

    
  end

  def profile
    params[:id].nil? ?  @user = current_user : @user = User.find(params[:id])

    # if params[:id].nil?
    #   @user = current_user
    # else 
    #   @user = User.find(params[:id])
    # end
  end

 
  def about 
  	
  end 
end
