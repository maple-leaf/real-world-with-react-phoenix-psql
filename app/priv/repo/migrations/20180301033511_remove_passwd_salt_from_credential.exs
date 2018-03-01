defmodule App.Repo.Migrations.RemovePasswdSaltFromCredential do
  use Ecto.Migration

  def change do
    alter table("credentials") do
      remove :passwd_salt
    end
  end
end
