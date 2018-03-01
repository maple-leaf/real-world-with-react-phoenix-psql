defmodule AppWeb.AuthController do
  use AppWeb, :controller
  alias App.User

  def login(conn, %{"username" => username, "passwd" => passwd}) do
    if User.validate(User.getUserByName(username), passwd) do
      json conn, %{"success" => true, "username" => username}
    else
      json conn, %{"success" => false, "username" => username}
    end

  end
end
