class SecretBlueprint < Blueprinter::Base
  identifier :id
  fields :url, :content

  view :extended do
    field :expires_at
    field :password_digest
  end
end
