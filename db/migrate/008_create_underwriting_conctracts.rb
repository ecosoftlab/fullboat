class CreateUnderwritingConctracts < ActiveRecord::Migration
  def self.up
    create_table :underwriting_conctracts do |t|
      t.column :name, :string
      t.column :body, :text
      t.column :underwriter, :string
      t.column :contat_name, :string
      t.column :contact_email, :string
      t.column :contact_phone, :string
      t.column :contract_url, :string
      t.column :expiration_date, :datetime

      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :underwriting_conctracts
  end
end
