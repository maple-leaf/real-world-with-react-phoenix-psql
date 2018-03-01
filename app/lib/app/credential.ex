defmodule App.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Credential


  schema "credentials" do
    field :email, :string
    field :user_id, :id
    field :passwd_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%Credential{} = credential, attrs) do
    credential
    |> cast(attrs, [:email, :user_id, :passwd_hash])
    |> validate_required([:email, :passwd_hash])
  end
end
