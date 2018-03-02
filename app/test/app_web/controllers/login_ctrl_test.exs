defmodule AppWeb.LoginControllerTest do
  use AppWeb.ConnCase

  test "POST /login", %{conn: conn } do
    username = "xx123"
    passwd = "xx123"
    postBody = ["username": username, "passwd": passwd]
    res = post conn, "/login", postBody
    assert json_response(res, 401) == %{"success" => false}
  end
end
