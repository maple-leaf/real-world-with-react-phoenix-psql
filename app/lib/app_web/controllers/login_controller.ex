defmodule AppWeb.LoginController do
  use AppWeb, :controller
  alias AppWeb.User

  def index(conn, %{"username" => username, "passwd" => passwd}) do
    json conn, %{"success" => false, "username" => username}
  end
end
