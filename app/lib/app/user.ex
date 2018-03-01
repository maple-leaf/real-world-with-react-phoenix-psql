defmodule App.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.User
  alias App.Repo


  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :string
    field :avatar, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :bio, :avatar])
    |> validate_required([:name, :email])
  end

  def getUserByName(username) when is_bitstring(username) do
    Repo.get_by User, %{"name": username}
  end

  def create(attrs \\ {}) do
    %User{}
    |> changeset(attrs)
    |> Repo.insert
  end
end
