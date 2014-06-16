class FixRetirementsSpelling < ActiveRecord::Migration
  def change
  	rename_table :retirments, :retirements
  end
end
