BINARY=roer

LDFLAGS="-X main.version=$(version)"


build: clean mod
	mkdir build
	env GOOS=darwin GOARCH=arm64 go build -ldflags ${LDFLAGS} -o build/${BINARY}-darwin-arm64 ./cmd/roer/main.go
	env GOOS=darwin GOARCH=amd64 go build -ldflags ${LDFLAGS} -o build/${BINARY}-darwin-amd64 ./cmd/roer/main.go
	env GOOS=linux GOARCH=amd64 go build -ldflags ${LDFLAGS} -o build/${BINARY}-linux-amd64 ./cmd/roer/main.go
	env GOOS=linux GOARCH=386 go build -ldflags ${LDFLAGS} -o build/${BINARY}-linux-386 ./cmd/roer/main.go
	env GOOS=windows GOARCH=386 go build -ldflags ${LDFLAGS} -o build/${BINARY}-windows-386 ./cmd/roer/main.go
	env GOOS=windows GOARCH=amd64 go build -ldflags ${LDFLAGS} -o build/${BINARY}-windows-amd64 ./cmd/roer/main.go

package:
	cd build
	find . -name '${BINARY}-*' -print -exec zip '{}'.zip '{}' \;

clean:
	rm -rf build

mod:
	rm -rf vendor
	git checkout vendor
	rm -rf go.sum
	rm -rf go.mod
	go mod init
	go mod tidy
	go mod vendor
