defmodule App.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.User
  alias App.Credential
  alias App.Repo
  import Bcrypt


  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :string
    field :avatar, :string
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :bio, :avatar])
    |> cast_assoc(:credential, required: true)
    |> validate_required([:name, :email])
  end

  def getUserByName(username) when is_bitstring(username) do
    Repo.get_by User, %{"name": username}
  end

  def create(attrs \\ %{}) do
    userWithCredential = transformToUser(attrs)

    %User{}
    |> changeset(userWithCredential)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.insert
  end

  defp transformToUser(attrs \\ %{}) do
    passwdHash = encryptPasswd(Map.get(attrs, :passwd))

    attrs
    |> Map.delete(:passwd)
    |> Map.put(:credential, %{ passwd_hash: passwdHash, email: Map.get(attrs, :email) })
  end

  defp encryptPasswd(passwd) when is_bitstring(passwd) do
    Bcrypt.hash_pwd_salt(passwd)
  end
end
