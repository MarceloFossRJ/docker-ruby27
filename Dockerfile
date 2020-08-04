FROM ruby:2.7.0-buster
MAINTAINER marcelo.foss.rj@gmail.com

# To prevent rake version incompatibility
RUN gem update rake

# Package update, install nodejs, yarn, imagemagick
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg \
    && apt-key add /root/yarn-pubkey.gpg \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs yarn \
    && apt-get install -y build-essential libpq-dev vim ghostscript imagemagick

# Copy application code
ADD Gemfile /app/
ADD Gemfile.lock /app/

# Change to the application's directory
ENV RAILS_ROOT /app
WORKDIR $RAILS_ROOT

# Set Rails environment to production
ENV RAILS_ENV $RAILS_ENV

# Install gems, nodejs and precompile the assets
#RUN bundle install

# Copy application code
COPY . .

# create folder to uploads & install vi
#RUN mkdir public/uploads

RUN chmod +x entrypoint.sh
