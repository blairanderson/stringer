class AddKeysToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :token, :text
    add_column :identities, :secret, :text
    add_column :identities, :expires_at, :timestamp
    add_column :identities, :expires, :boolean
  end
end
