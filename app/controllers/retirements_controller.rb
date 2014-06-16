class RetirementsController < ApplicationController
	def new
	end

	def create
		@retirement = Retirement.new(params[:retirement])

		@retirement.save
	end

	private
		def article_params
			params.requir(:retirement).permit(:portfolio_type, :current_age, :current_amount, :anual_contributions, :desired_anual_income)
		end
end
