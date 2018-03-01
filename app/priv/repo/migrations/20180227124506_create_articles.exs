defmodule App.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :description, :string
      add :body, :text
      add :tags_list, {:array, :string}

      timestamps()
    end

  end
end
