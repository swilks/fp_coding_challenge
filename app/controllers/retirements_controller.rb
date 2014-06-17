class RetirementsController < ApplicationController
	def new
		@retirement = Retirement.new
	end

	def create
		@retirement = Retirement.new(retirement_params)

		#if save is successful go to index, otherwise display error message(s)
		if @retirement.save
			redirect_to retirements_path
		else 
			render 'new'
		end

	end

	def index
		@retirements = Retirement.all
	end

	# Require the retirment object to be present and allow all members
	private
		def retirement_params
			params.require(:retirement).permit(:portfolio_type, :current_age, :current_amount, :anual_contributions, :desired_anual_income, :retirement_age)
		end
end
