class Retirement < ActiveRecord::Base
	before_create :calculate_retirement_age;

	private 
		def calculate_retirement_age
			file = File.read('lib/assets/retirement-data.json')
			hash = JSON.parse(file)

			self.retirement_age = hash.fetch(self.portfolio_type).fetch(self.current_age.to_s).fetch(self.current_amount.to_s).fetch(self.anual_contributions.to_s).fetch(self.desired_anual_income.to_s)
		end
end
