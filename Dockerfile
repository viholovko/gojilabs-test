FROM ruby:3.2.2

# Set environment variables
ENV RAILS_ENV=development

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# Set working directory
WORKDIR /app

# Install Gems
COPY Gemfile* ./
RUN bundle install

# Copy the project files
COPY . .

# Expose the app port
EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]