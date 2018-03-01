defmodule AppWeb.LoginControllerTest do
  use AppWeb.ConnCase

  test "POST /api/login", %{conn: conn } do
    username = "test"
    passwd = "123"
    postBody = ["username": username, "passwd": passwd]
    res = post conn, "/api/login", postBody
    assert json_response(res, 200) == %{"success" => false, "username" => username}
  end
end
