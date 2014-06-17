class Retirement < ActiveRecord::Base
	validates :portfolio_type, :current_age, :current_amount, :anual_contributions, :desired_anual_income, presence: true
	validates :current_age, :current_amount, :anual_contributions, :desired_anual_income, numericality: { only_integer: true, message: "must be a number" }
	validates :current_age, inclusion: { in: 25..50, message: "must be within 25 and 50" }
	validates :current_amount, inclusion: { in: 0..1000000, message: "must be within 0 and 1,000,000" }
	validates :anual_contributions, inclusion: { in: 0..100000, message: "must be within 0 and 100,000" }
	validates :desired_anual_income, inclusion: { in: 50000..200000, message: "must be within 50,000 and 200,000" }
	
	validates_each :current_amount, :anual_contributions, :desired_anual_income do |record, attr, value| 
		record.errors.add attr, 'must be a multiple of 10,000' if value == nil || value % 10000 != 0
	end


	before_create :calculate_retirement_age;

	private 
		def calculate_retirement_age
			file = File.read('lib/assets/retirement-data.json')
			hash = JSON.parse(file)

			self.retirement_age = hash.fetch(self.portfolio_type).fetch(self.current_age.to_s).fetch(self.current_amount.to_s).fetch(self.anual_contributions.to_s).fetch(self.desired_anual_income.to_s)
		end
end
