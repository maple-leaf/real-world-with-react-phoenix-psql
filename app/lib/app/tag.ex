defmodule App.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Tag


  schema "tags" do
    field :name, :string
    belongs_to :article, App.Article

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
