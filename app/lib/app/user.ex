defmodule App.User do
  @moduledoc """
    User Model
  """
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

  @doc """
  get user by given user name

  ## Parameters
    - username: String

  ## Examples
  ```
  iex> User.getUserByName("Ben")
  %{name: "Ben", ...}

  iex> User.getUserByName("not_exist")
  nil
  ```
  """
  def getUserByName(username) when is_bitstring(username) do
    User
    |> Repo.get_by(%{"name": username})
    |> Repo.preload(:credential)
  end

  @doc"""
  create user with given attributes and insert into db

  ## Parameters
    - attrs: Map - contains user info
    - attrs.name* String - user name
    - attrs.email* String - user email
    - attrs.passwd* String - password of user
    - attrs.bio? String - bio of user
    - attrs.avatar? String - avatar address of user

  ## Examples
  ```
  iex> User.create(%{name: "Ben", email: "ben@example.com", passwd: "random123"})

  iex> User.create(%{name: "Ben", email: "ben@example.com", passwd: "random123", bio: "a simple bio"})
  ```
  """
  def create(attrs \\ %{}) do
    userWithCredential = transformToUser(attrs)

    %User{}
    |> changeset(userWithCredential)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.insert
  end

  @doc """
  validate user with password

  ## Parameters
    - user* %User{} - user changeset
    - passwd* String - password to verify

  ## Examples
  ```
  iex> User.validate(User.getUserByName("ben"), "passwordOfBen")
  true

  iex> User.validate(User.getUserByName("ben"), "passwordOfOther")
  false

  iex> User.validate(User.getUserByName("not_exist"), "password")
  false
  ```
  """
  def validate(%User{} = user, passwd) do
      Bcrypt.verify_pass(passwd, user.credential.passwd_hash)
  end
  def validate(user, passwd) when is_nil(user) do
      false
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
