defmodule Servy.Handler do
  def handle(request) do
   request
   |> parse
   |> route
   |> format_response
  end

  def parse(request) do
    request_line = String.split(request, "\n") |> List.first
    [method, path, _version] = String.split(request_line, " ")

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
