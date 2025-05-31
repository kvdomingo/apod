FROM golang:1.21-alpine AS build

ARG TARGETARCH=amd64

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=${TARGETARCH}

WORKDIR /build

COPY . .

RUN go build -mod=readonly -o /app

FROM scratch AS prod

COPY --from=build /app /app

CMD [ "/app" ]
