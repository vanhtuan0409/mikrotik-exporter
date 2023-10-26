# go run -ldflags "-X mikrotik-exporter/cmd.version=6.6.7-BETA -X mikrotik-exporter/cmd.shortSha=`git rev-parse HEAD`" main.go version

VERSION=`cat VERSION`
SHORTSHA=`git rev-parse --short HEAD`

LDFLAGS=-X main.appVersion=$(VERSION)
LDFLAGS+=-X main.shortSha=$(SHORTSHA)

build:
	go build -ldflags "$(LDFLAGS)" -o bin/mikrotik-exporter .

release:
	CGO_ENABLED=0 go run github.com/mitchellh/gox -os="linux freebsd netbsd" -arch="amd64 arm arm64 386" -parallel=4 -ldflags "$(LDFLAGS)" -output "dist/mikrotik-exporter_{{.OS}}_{{.Arch}}"
