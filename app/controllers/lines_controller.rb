class LinesController < ApplicationController

	def new
		params[:previous_line_id].nil? ? @line = Line.new : @line = Line.find(params[:previous_line_id]).next_lines.create
	end

	def create
		@line = Line.create(line_params)
		redirect_to line_path(@line)
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

		render :json => @line.next_lines
	end

	private

	def line_params
		params.require(:line).permit(:text, :previous_line_id)
	end


end
