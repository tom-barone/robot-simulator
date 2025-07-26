#!/usr/bin/env bash

# Download the oauth2-proxy binary if it doesn't exist
if [ ! -f ./bin/oauth2-proxy ]; then
	system=$(uname -s | tr '[:upper:]' '[:lower:]')
	arch=$(uname -m)
	case $arch in
	x86_64) arch=amd64 ;;
	arm64) arch=arm64 ;;
	aarch64) arch=arm64 ;;
	*) printf "Unsupported architecture: %s\n" "$arch" && exit 1 ;;
	esac

	version="v7.6.0"
	filename="oauth2-proxy-$version.$system-$arch.tar.gz"
	url="https://github.com/oauth2-proxy/oauth2-proxy/releases/download/${version}/${filename}"
	curl --silent -L "$url" -o oauth2-proxy.tar.gz
	tar -xf oauth2-proxy.tar.gz --strip-components=1
	rm oauth2-proxy.tar.gz
	mv oauth2-proxy ./bin/oauth2-proxy
fi

# https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview#generating-a-cookie-secret
cookie_secret="$(dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 | tr -d -- '\n' | tr -- '+/' '-_')"

bundle exec rake docs

# Start the proxy on $PORT and redirect traffic to the docs directory
# - The http-address needs to be set to 0.0.0.0 when deployed with Dokku
# https://oauth2-proxy.github.io/oauth2-proxy/7.6.x/configuration/providers/github
./bin/oauth2-proxy \
	--http-address="$HOSTNAME:$PORT" \
	--upstream="file://$PWD/doc#/" \
	--cookie-secret="$cookie_secret" \
	--email-domain="*" \
	--provider=github \
	--github-user="tom-barone" \
	--banner="Please sign in" \
	--custom-sign-in-logo="-" \
	--footer="Robot Simulator" \
	--reverse-proxy=true
