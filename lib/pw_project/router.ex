defmodule PwProject.Router do
  import Plug.Conn
  use Plug.Router
  require Logger

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Welcome!")
  end

  get "/remove" do
    conn = Plug.Conn.fetch_query_params(conn)
    %{"string" => string, "char" => char} = conn.query_params
    response = String.replace(string, char, "")
    send_resp(conn, 200, response)
  end

  match _ do
    send_resp(conn, 404, "Not found!")
  end
end
