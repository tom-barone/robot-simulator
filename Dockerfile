# Alpine = nice and small
# Friends don't bloat other friends machines with massive docker images
FROM ruby:3.4.4-alpine
RUN apk add --no-cache build-base

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["ruby", "lib/robot.rb"]
