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

  test "handle bears request" do
    request = """
    GET /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 5

    Bears
    """

    response = Handler.handle(request)
    assert response == expected_response
  end

  test "unknown path" do
    path = "onepiece"
    request = """
    GET /#{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 404 Not Found
    Content-Type: text/html
    Content-Length: 17

    No /#{path} here
    """
    response = Handler.handle(request)
    assert response == expected_response
  end

  test "handling single GET request" do
    response_body = "Bear 1"
    request = """
    GET /bears/1 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{response_body |> String.length}

    #{response_body}
    """
    assert Handler.handle(request) == expected_response
  end

end
