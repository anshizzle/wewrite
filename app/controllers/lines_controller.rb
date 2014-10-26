class LinesController < ApplicationController

	def new
		params[:previous_line_id].nil? ? @line = Line.new : @line = Line.find(params[:previous_line_id]).next_lines.create
		

		render :layout => false if params[:ajax]
	end

	def create
		if user_signed_in?
			@line = Line.create(line_params)
			redirect_to line_path(@line)
		else
			byebug
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
		@next_lines = @lines.last.next_lines
		@lines.last.update_attribute(:score, @lines.last.score + 1)
	end

	def select_next
		@line = Line.find(params[:id])
		@line.update_attribute(:score, @line.score + 1)

		@next_lines = @line.next_lines
		render :layout => false
	end

	private

	def line_params
		params.require(:line).permit(:text, :previous_line_id, :user_id)
	end


end
