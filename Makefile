APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ogavrylenko
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
#posible OS: linux,darwin,windows
TARGETOS=linux
#posible ARCH: amd64,arm,386
TARGETARCH=arm64

format:
	gofmt -s -w ./

get:
	go get	

lint:
	golint

test:
	go test -v

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/OleksandrOHavrylenko/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot