defmodule Servy.Handler do
  def handle(request) do
   request
   |> parse
   |> route
   |> format_response
  end

  def parse(request) do
    Servy.Parser.parse(request)
  end

  def log(conv) do
    IO.inspect conv
  end

  def route(conv = %{ path: "/wildthings" }) do
    %{ conv | resp_body: "Bears, Lions, Tigers"}
  end

  def route(conv = %{ path: "/bears" }) do
    %{ conv | resp_body: "Bears"}
  end

  def route(conv = %{ path: path } ) do
    %{ conv | resp_body: "No #{path} here"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end
