require 'json'

class RetirementsController < ApplicationController
	def new
		@retirement = Retirement.new
	end

	def create
		@retirement = Retirement.new(params[:retirement])

		if @retirement.save
			after_create
		end 

	end

	def after_create
		url = URI.parse('https://s3.amazonaws.com/fa-public/interview/retirement-data.json')
		req = Net::HTTP::Get.new(url.path)
		res = Net::HTTP.start(url.host, url.port) {|http|
			http.request(req)
		}
		hash = JSON.parse res.body
		@retirement.retirement_age = hash.fetch(@retirement.portfolio_type).fetch(@retirement.current_age).fetch(@retirement.current_amount).fetch(@retirement.anual_contributions).fetch(@retirement.desired_anual_income)
		redirect_to @retirement
	end

	private
		def retirement_params
			params.require(:retirement).permit(:portfolio_type, :current_age, :current_amount, :anual_contributions, :desired_anual_income)
		end
end
