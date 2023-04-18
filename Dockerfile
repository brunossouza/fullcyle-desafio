# syntax=docker/dockerfile:1

ARG GO_VERSION=1.20
FROM golang:${GO_VERSION} AS build
WORKDIR /src

COPY . .

RUN go mod download -x

RUN CGO_ENABLED=0 go build -o /bin/app .


FROM scratch AS run
WORKDIR /app

COPY --from=build /bin/app /bin/app

ENTRYPOINT [ "/bin/app" ]
