alias Posion

defimpl Phoenix.HTML.Safe, for: Map do
  def to_iodata(data), do: data |> Poison.encode! |> Plug.HTML.html_escape
end
