defmodule HandlerTest do
  use ExUnit.Case

  alias Servy.Handler

  test "handle sample request" do
    request = """
    GET /wildthings HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """

    response = Handler.handle(request)
    assert response == expected_response
  end
end
