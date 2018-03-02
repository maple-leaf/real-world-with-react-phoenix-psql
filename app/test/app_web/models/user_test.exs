defmodule AppWeb.UserTest do
  use AppWeb.ConnCase
  alias App.User

  @basic_attrs %{bio: "my life", email: "pat@example.com", name: "Pat Example"}
  @attrs_with_valid_passwd Map.merge(@basic_attrs, %{passwd: "random", passwd_confirmation: "random"})
  @attrs_with_invalid_passwd Map.merge(@basic_attrs, %{passwd: "random", passwd_confirmation: "other"})
  @invalid_attrs %{}

  describe "user schema" do
    test "changeset with valid attrs" do
      changeset = User.changeset(%User{}, @attrs_with_valid_passwd)
      assert changeset.valid?
    end

    test "changeset with invalid attrs" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "model operation" do
    test "User.create with valid attrs" do
      {:ok, user} = User.create(@attrs_with_valid_passwd)
      assert user.name === Map.get(@attrs_with_valid_passwd, :name)
      assert user.email === Map.get(@attrs_with_valid_passwd, :email)
      assert user.bio === Map.get(@attrs_with_valid_passwd, :bio)
      assert user.credential.email === user.email
      assert user.credential.user_id === user.id
      assert user.credential.passwd_hash !== nil
    end

    test "User.create with invalid passwd_confirmation" do
      {:error, message} = User.create(@attrs_with_invalid_passwd)
      assert message === "password not euqal to confirmation"
    end

    test "User.getUserByName" do
      userNonExist = User.getUserByName "no_exist"
      assert userNonExist === nil

      {:ok, user} = User.create(@attrs_with_valid_passwd)
      name = Map.get(@attrs_with_valid_passwd, :name)
      userExist = User.getUserByName name
      assert userExist !== nil
      assert userExist.name === name
    end
  end
end
