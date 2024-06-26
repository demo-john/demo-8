FROM cgr.dev/chainguard/go@sha256:605d81422aba573c17bfd6029a217e94a9575179a98355a99acbb6e028ca883b AS builder

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT=""
ARG LDFLAGS

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    GOARM=${TARGETVARIANT}

WORKDIR /build

COPY . .

RUN go build -o bin/software

FROM golang:alpine3.18

COPY --from=builder /build/bin/software /software

ENTRYPOINT ["/software"]
