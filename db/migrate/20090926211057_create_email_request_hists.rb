class CreateEmailRequestHists < ActiveRecord::Migration
  def self.up
    create_table :email_request_hists do |t|
      t.string :code
      t.string :action
      t.integer :status_id
      t.integer :record_id

      t.timestamps
    end
  end

  def self.down
    drop_table :email_request_hists
  end
end
