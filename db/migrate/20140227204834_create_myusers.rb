class CreateMyusers < ActiveRecord::Migration
  def change
    create_table :myusers do |t|
      t.string :uname
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
