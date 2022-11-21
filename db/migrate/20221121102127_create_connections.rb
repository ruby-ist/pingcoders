class CreateConnections < ActiveRecord::Migration[7.0]
	def change
		create_table :connections do |t|
			t.references :sent , index: true, foreign_key: {to_table: :users}
			t.references :received, index: true, foreign_key: {to_table: :users}
			t.integer :status, default: 0

			t.timestamps
		end
	end
end
