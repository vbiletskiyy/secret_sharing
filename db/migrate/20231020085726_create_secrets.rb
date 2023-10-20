class CreateSecrets < ActiveRecord::Migration[7.1]
  def change
    create_table :secrets do |t|
      t.text       :content, null: false
      t.string     :password_digest, null: false
      t.string     :url, null: false
      t.datetime   :expires_at
      t.references :user

      t.timestamps
    end
  end
end
