class CreateCompany < ActiveRecord::Migration[7.0]
	def change
		create_table :companies do |t|
			t.string :role
			t.string :name
			t.belongs_to :user

			t.timestamps
		end
	end
end
