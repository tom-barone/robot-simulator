# Alpine = nice and small
# Friends don't bloat other friends machines with massive docker images
FROM ruby:3.4.4-alpine

WORKDIR /app

COPY Gemfile Gemfile.lock ./

# Remove build dependencies after `bundle install` to keep the image small
RUN apk add --no-cache --virtual .build-deps build-base yaml-dev \
		&& bundle install \
		&& bundle clean --force \
		&& rm -rf /usr/local/bundle/cache \
		&& apk del .build-deps

COPY . .

CMD ["ruby", "lib/robot_simulator.rb"]
