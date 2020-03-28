defmodule Servy.Handler do
  def handle(request) do
   request
   |> parse
   |> route
   |> format_response
  end

  def parse(request) do
    [method, path, _version] = request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{ method: method, path: path, resp_body: ""}
  end

  def route(conv) do
    %{ method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    #{conv.resp_body}
    """
  end
end
