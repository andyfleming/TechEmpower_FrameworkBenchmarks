import gleam/http/elli
import gleam/http/response.{type Response}
import gleam/http/request.{type Request}
import gleam/bytes_builder.{type BytesBuilder}
import birl
import gleam/io

// Define a HTTP service
//
pub fn my_service(_request: Request(t)) -> Response(BytesBuilder) {
  let body = bytes_builder.from_string("Hello, world!")

  response.new(200)
  |> response.prepend_header("content-type", "text/plain")
  |> response.prepend_header("server", "gleam")
  |> response.prepend_header("date", birl.to_http(birl.now()))
  |> response.set_body(body)
}

pub fn main() {
  io.debug(birl.to_iso8601(birl.now()))

  elli.become(my_service, on_port: 8080)
}
