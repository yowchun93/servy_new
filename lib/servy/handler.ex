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

  def route(conv = %{ path: "/wildthings" }) do
    %{ conv | resp_body: "Bears, Lions, Tigers", status: 200 }
  end

  def route(conv = %{ path: "/bears" }) do
    %{ conv | resp_body: "Bears", status: 200 }
  end

  def route(conv = %{ path: "/bears/" <> id }) do
    %{ conv | resp_body: "Bear #{id}", status: 200}
  end

  def route(conv = %{ path: path } ) do
    %{ conv | resp_body: "No #{path} here", status: 404 }
  end

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end
