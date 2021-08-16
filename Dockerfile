FROM ruby:2.7.0-slim-buster

# Install necessary dependencies
RUN apt-get update && apt-get install -y  \
        curl \
        build-essential \
        libpq-dev && \
        curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
        apt-get update && apt-get install -y nodejs yarn && \
        rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Install node dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Add node_modules binaries to the PATH
ENV PATH="/usr/src/app/node_modules/.bin:$PATH"

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Get application content
COPY . .

# Build assets
RUN bundle exec rails assets:precompile

# Start the server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
