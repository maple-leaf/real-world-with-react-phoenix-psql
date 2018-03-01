defmodule AppWeb.AuthController do
  use AppWeb, :controller
  alias App.User

  def login(conn, %{"username" => username, "passwd" => passwd}) do
    user = User.getUserByName(username)

    if User.validate(user, passwd) do
      conn
      |> fetch_session
      |> put_session(:user_id, user.id)
      |> json(%{"success" => true})
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{"success" => false})
    end
  end

  def logout(conn, _) do
    conn
    |> fetch_session
    |> configure_session(drop: true)
    |> json(%{"success" => true})
  end

  def test(conn, _) do
    conn
    |> text("test")
  end
end
