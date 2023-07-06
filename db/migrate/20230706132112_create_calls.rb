class CreateCalls < ActiveRecord::Migration[7.0]
  def change
    create_table :calls do |t|
      t.string :motive
      t.date :date
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
