FROM golang:1.21-alpine AS build

ENV CGO_ENABLED 0
ENV GOOS linux
ENV GOARCH amd64

WORKDIR /build

COPY . .

RUN go build -mod=readonly -o /app

FROM scratch AS prod

COPY --from=build /app /app

CMD [ "/app" ]
