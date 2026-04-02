FROM golang:1.26-alpine AS build

ARG TARGETARCH=amd64

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=${TARGETARCH}

WORKDIR /build

COPY go.* ./
COPY *.go ./

RUN go build -mod=readonly -o /app

FROM scratch AS prod

COPY --from=build /app /app

CMD [ "/app" ]
