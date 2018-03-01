defmodule App.Repo.Migrations.AddPasswdToCredentials do
  use Ecto.Migration

  def change do
    alter table(:credentials) do
      add :passwd_hash, :string
      add :passwd_salt, :string
    end
  end
end
