FROM ghcr.io/gleam-lang/gleam:v1.0.0-erlang-alpine

WORKDIR /app

COPY ./src /app/src
COPY ./gleam.toml /app
COPY ./manifest.toml /app

RUN gleam build

EXPOSE 8080

CMD ["gleam", "run"]
