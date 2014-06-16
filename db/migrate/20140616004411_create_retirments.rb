class CreateRetirments < ActiveRecord::Migration
  def change
    create_table :retirments do |t|
      t.string :portfolio_type
      t.integer :current_age
      t.integer :current_amount
      t.integer :anual_contributions
      t.integer :desired_anual_income
      t.integer :retirement_age

      t.timestamps
    end
  end
end
