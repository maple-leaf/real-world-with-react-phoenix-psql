defmodule AppWeb.AuthControllerTest do
  use AppWeb.ConnCase

  @username "xx123"
  @email "xx123@test.com"
  @passwd "xx123"

  test "POST /register with valid attrs", %{conn: conn } do
    postBody = ["name": @username, "email": @email, "passwd": @passwd, "passwd_confirmation": @passwd]
    res = post conn, "/register", postBody
    assert json_response(res, 201) == %{"success" => true}
  end

  test "POST /register with invalid attrs", %{conn: conn } do
    postBody = ["name1": @username, "email": @email, "passwd": @passwd, "passwd_confirmation": @passwd]
    res = post conn, "/register", postBody
    assert json_response(res, 400) == %{"success" => false, "message" => "bad request"}
  end

  test "POST /signin with non-exist user", %{conn: conn } do
    postBody = ["username": @username, "passwd": @passwd]
    res = post conn, "/signin", postBody
    assert json_response(res, 401) == %{"success" => false}
  end

  test "POST /signin with exist user", %{conn: conn } do
    postBody = ["name": @username, "email": @email, "passwd": @passwd, "passwd_confirmation": @passwd]
    post conn, "/register", postBody

    postBody = ["username": @username, "passwd": @passwd]
    res = post conn, "/signin", postBody
    assert json_response(res, 200) == %{"success" => true}
  end
end
