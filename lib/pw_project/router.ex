defmodule PwProject.Router do
  import Plug.Conn
  use Plug.Router
  use Plug.ErrorHandler

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Welcome!")
  end

  get "/remove" do
    conn = fetch_query_params(conn)

    try do
      %{"string" => string, "char" => char} = conn.query_params
      if String.length(char) != 1, do: throw(char)
      {string, char}
    rescue
      MatchError ->
        send_resp(conn, 400, "Bad request!")
    catch
      char ->
        send_resp(conn, 400, "Bad request! '#{char}' is not one character!")
    else
      {string, char} ->
        response = String.replace(string, char, "")
        send_resp(conn, 200, response)
    end
  end

  match _ do
    send_resp(conn, 404, "Not found!")
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong!")
  end
end
