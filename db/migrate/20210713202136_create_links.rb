class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :fintoc_id
      t.string :fintoc_token

      t.timestamps
    end
  end
end
