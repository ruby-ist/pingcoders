class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.string :name

      t.timestamps
    end

    create_table :skill_sets do |t|
      t.belongs_to :user
      t.belongs_to :skill
      t.timestamps
    end

    create_table :languages do |t|
      t.string :name

      t.timestamps
    end

    create_table :known_languages do |t|
      t.belongs_to :user
      t.belongs_to :language
      t.timestamps
    end

    create_table :numbers do |t|
      t.string :number
      t.belongs_to :user

      t.timestamps
    end

    create_table :emails do |t|
      t.string :email
      t.belongs_to :user

      t.timestamps
    end

    create_table :addresses do |t|
      t.text :address
      t.belongs_to :user

      t.timestamps
    end
  end
end
