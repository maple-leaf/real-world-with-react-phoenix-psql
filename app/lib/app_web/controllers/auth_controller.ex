defmodule AppWeb.AuthController do
  use AppWeb, :controller
  alias App.User

  def signin(conn, %{"email" => email, "passwd" => passwd}) do
    user = User.getUserByEmail(email)

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

  def signout(conn, _) do
    conn
    |> fetch_session
    |> configure_session(drop: true)
    |> json(%{"success" => true})
  end

  def register(conn, %{"name" => name, "email" => email, "passwd" => passwd, "passwd_confirmation" => passwd_confirmation} = attrs) do
    case User.create(attrs) do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> json(%{"success" => true})
      {:error, errors} ->
        if is_bitstring(errors) do
          message = errors
        else
          message = process_changset_errors(errors)
        end
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{"success" => false, "message" => message})
    end
  end
  def register(conn, _) do
    conn
    |> put_status(:bad_request)
    |> json(%{"success" => false, "message" => "bad request"})
  end

  defp process_changset_errors(%{errors: errors} = changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn
      {msg, opts} -> String.replace(msg, "%{count}", to_string(opts[:count]))
      msg -> msg
    end)
  end
end
