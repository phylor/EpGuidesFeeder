# EpGuidesFeeder

![Screenshot](http://phylor.github.io/EpGuidesFeeder/img/screenshot.png)

## What is it?

Converts the show information from epguides.com to an RSS feed.

## Running it

### Docker Container

To run it in a docker container on port `2000`:

    docker run --name epguidesfeeder -p 2000:80 phylor/epguidesfeeder

### Run it manually

You need Ruby installed. Then do:

    bundle install
    rackup

## How do I use it?

Search a show by calling `/search?q=my%20search%20term`. Copy the shown link of your desired show and add it to your RSS reader.
