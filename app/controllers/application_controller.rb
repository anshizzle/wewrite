class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index

  	
  	params[:start].nil? ? @start = 0 : @start = params[:start].to_i
    params[:mode].nil? ? @mode = "top" : @mode = params[:mode]
  	@num_display = 20
    if @mode == "new"
      @lines = Story.created_at_desc.offset(@start).limit(@num_display).map { |story| story.first_line }
      Story.count <= (@start + @num_display) ? @has_next = false : @has_next = true
    elsif @mode == "recent"
      @lines = Line.created_at_desc.offset(@start).limit(@num_display)
      Line.count <= (@start + @num_display) ? @has_next = false : @has_next = true
    else
      @lines = Line.first_lines.sort_by { |line| line.total_score }.reverse
      @lines = @lines.slice(@start, @num_display)
      Story.count <= (@start + @num_display) ? @has_next = false : @has_next = true

    end
    
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
