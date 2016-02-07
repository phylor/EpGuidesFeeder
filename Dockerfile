FROM ruby

RUN mkdir -p /opt/epguide
COPY . /opt/epguide/

WORKDIR /opt/epguide
RUN bundle install

CMD ["rackup", "-p", "80"]
