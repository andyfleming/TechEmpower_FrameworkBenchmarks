import gleam/bytes_builder
import gleam/erlang/process
import gleam/http/request.{type Request}
import gleam/http/response.{type Response as ResponseType, Response}
import mist.{type Connection, type ResponseData}
import birl

pub fn main() {
  let not_found =
    response.new(404)
    |> response.set_body(mist.Bytes(bytes_builder.new()))

  let assert Ok(_) =
    fn(req: Request(Connection)) -> ResponseType(ResponseData) {
      case request.path_segments(req) {
        ["plaintext"] -> hello(req)
        _ -> not_found
      }
    }
    |> mist.new
    |> mist.port(8080)
    |> mist.start_http

  process.sleep_forever()
}

fn hello(_request: Request(Connection)) -> ResponseType(ResponseData) {
  let body = bytes_builder.from_string("Hello, World!")

  Response(
    200,
    [
      #("content-type", "text/plain"),
      #("server", "gleam/mist"),
      #("date", birl.to_http(birl.now())),
    ],
    mist.Bytes(body),
  )
}
