FROM ruby:2.7.5-alpine

# Install system dependencies
# Alpine uses apk instead of apt-get, and different package names
RUN apk add --no-cache \
  build-base \
  nodejs \
  sqlite-dev \
  tzdata \
  shared-mime-info \
  gcompat
# Set working directory inside the container
WORKDIR /app


# Copy Gemfile first (so Docker caches this layer if gems haven't changed)
COPY Gemfile Gemfile.lock ./

# Install gems
ENV BUNDLE_FORCE_RUBY_PLATFORM=1
RUN gem install bundler:1.17.2 && bundle install

# Copy the rest of the app
COPY . .

# Precompile assets for production (optimal for dev)
# Expose the port rails runs on
EXPOSE 3000

# Create and migrate the database, then start the server
CMD ["sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails s -b '0.0.0.0'"]



