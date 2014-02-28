class AddDownloadToMyusers < ActiveRecord::Migration
  def change
    change_table :myusers do |t|
      t.has_attached_file :download
    end     
  end
end
