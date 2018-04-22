defmodule AppWeb.PageController do
  use AppWeb, :controller

  alias Redix
  alias Posion

  def index(conn, params) do
    IO.inspect(Mix.env)
    {:ok, redisConn} = Redix.start_link(host: "127.0.0.1", port: 6379)
    currentManifest = getVersion(redisConn, Map.get(params, "new_version"))
    render(conn, "index.html", manifest: currentManifest, isProduction: Mix.env == :prod)
  end

  defp getVersion(redisConn, currentVersionParam) when currentVersionParam != nil do
    Redix.command(redisConn, ["SET", "currentManifest", currentVersionParam])
    Poison.decode!(currentVersionParam)
  end
  defp getVersion(redisConn, currentVersionParam) do
    case Redix.command(redisConn, ["GET", "currentManifest"]) do
      {:ok, manifest} when manifest != nil -> Poison.decode!(manifest)
      _ -> %{}
    end
  end
end
