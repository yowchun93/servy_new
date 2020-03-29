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

  def route(conv) do
    if conv.path == "/wildthings" do
      %{ conv | resp_body: "Bears, Lions, Tigers"}
    else
      %{ conv | resp_body: "Bears"}
    end
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
