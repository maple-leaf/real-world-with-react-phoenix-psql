defmodule AppWeb.AuthView do
  use AppWeb, :view
  alias AppWeb.UserView

  def render("one.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      bio: user.bio || "",
      avatar: user.avatar || ""
    }
  end
end
