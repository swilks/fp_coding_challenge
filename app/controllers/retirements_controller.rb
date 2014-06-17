class RetirementsController < ApplicationController
	def new
		@retirement = Retirement.new
	end

	def create
		@retirement = Retirement.new(retirement_params)

		if @retirement.save
			redirect_to retirements_path
		else 
			render 'new'
		end

	end

	def index
		@retirements = Retirement.all
	end

	private
		def retirement_params
			params.require(:retirement).permit(:portfolio_type, :current_age, :current_amount, :anual_contributions, :desired_anual_income, :retirement_age)
		end
end
