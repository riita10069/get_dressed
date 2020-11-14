class CreateDresseds < ActiveRecord::Migration[6.0]
  def change
    create_table :dresseds do |t|
      t.date :day

      t.timestamps
    end
  end
end
