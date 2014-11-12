class LinesController < ApplicationController

	def new
		params[:previous_line_id].nil? ? @line = Line.new : @line = Line.find(params[:previous_line_id]).next_lines.create
		
		@lines = @line.collect_lines

		@ajax = true if params[:ajax]
		render :layout => false if params[:ajax]

	end

	def create
		if user_signed_in?
			@line = Line.create(line_params)
			if @line
			if params[:line][:previous_line_id].empty?

					@line.story = Story.create(:first_line_id => @line.id)
					@line.story.collaborators << current_user
					@line.save
				else
					@line.story = @line.previous_line.story
					@line.story.collaborators << current_user
					@line.save
				end

				redirect_to line_path(@line)
			else
				flash[:error] = @line.errors
				redirect_to line_path(Line.find(params[:line][:previous_line_id]))
			end
			
		else
			
			flash[:error] = "Please sign in or register before creating a line!"
			unless params[:line][:previous_line_id].empty?
				redirect_to line_path(Line.find(params[:line][:previous_line_id]))
			else
				redirect_to root_path
			end
		end

	end



	# params[:id] should correspond to the first line of the story.
	# if params[:deeper_line_id] is not nil, that means that they want to render up to the nested line id
	def show
		@lines = Line.find(params[:id]).collect_lines
		@next_lines = @lines.last.next_lines.ranked
		@lines.last.update_attribute(:score, @lines.last.score + 1)
		
	end

	def branch
		@lines = Line.find(params[:id]).collect_lines
	end

	def select_next
		@line = Line.find(params[:id])
		@line.update_attribute(:score, @line.score + 1)
		@lines = [@line]

		@next_lines = @line.next_lines.ranked
		render :layout => false
	end

	def send_invite
		if user_signed_in?
			UserInvite.send_invite_email(current_user,Line.find(params[:id]), params[:email]).deliver
			flash[:notice] = "Your invite was sent!"
		else
			flash[:error] = "Please sign in"
		end
		redirect_to Line.find(params[:id])
	end

	private

	def line_params
		params.require(:line).permit(:text, :previous_line_id, :user_id)
	end

end
