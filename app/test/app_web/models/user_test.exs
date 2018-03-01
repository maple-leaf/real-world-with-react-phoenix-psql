defmodule AppWeb.UserTest do
  use AppWeb.ConnCase
  alias App.User

  @not_transformed_attrs %{bio: "my life", email: "pat@example.com", name: "Pat Example", passwd: "random"}
  @valid_attrs %{bio: "my life", email: "pat@example.com", name: "Pat Example", credential: %{passwd_hash: "randomhash", email: "pat@example.com"}}
  @invalid_attrs %{}

  describe "user schema" do
    test "changeset with valid attrs" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attrs" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "model operation" do
    test "User.create" do
      {:ok, user} = User.create(@not_transformed_attrs)
      assert user.name === Map.get(@not_transformed_attrs, :name)
      assert user.email === Map.get(@not_transformed_attrs, :email)
      assert user.bio === Map.get(@not_transformed_attrs, :bio)
      assert user.credential.email === user.email
      assert user.credential.user_id === user.id
      assert user.credential.passwd_hash !== nil
    end

    test "User.getUserByName" do
      userNonExist = User.getUserByName "no_exist"
      assert userNonExist === nil

      {:ok, user} = User.create(@not_transformed_attrs)
      name = Map.get(@not_transformed_attrs, :name)
      userExist = User.getUserByName name
      assert userExist !== nil
      assert userExist.name === name
    end
  end
end
