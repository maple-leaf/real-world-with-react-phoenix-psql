defmodule AppWeb.UserTest do
  use AppWeb.ConnCase
  alias App.User

  @valid_attrs %{bio: "my life", email: "pat@example.com", name: "Pat Example"}
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
      {:ok, user} = User.create(@valid_attrs)
      assert user.name === Map.get(@valid_attrs, :name)
      assert user.email === Map.get(@valid_attrs, :email)
      assert user.bio === Map.get(@valid_attrs, :bio)
    end

    test "User.getUserByName" do
      userNonExist = User.getUserByName "abc"
      assert userNonExist === nil

      {:ok, user} = User.create(@valid_attrs)
      name = Map.get(@valid_attrs, :name)
      userExist = User.getUserByName name
      assert userExist !== nil
      assert userExist.name === name
    end
  end
end
