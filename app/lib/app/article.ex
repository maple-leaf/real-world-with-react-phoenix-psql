defmodule App.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Article


  schema "articles" do
    field :body, :string
    field :description, :string
    field :tagList, {:array, :string}
    field :title, :string
    belongs_to :user, App.User

    timestamps()
  end

  @doc false
  def changeset(%Article{} = article, attrs) do
    article
    |> cast(attrs, [:title, :description, :body, :tagList])
    |> validate_required([:title, :description, :body, :tagList])
  end
end
