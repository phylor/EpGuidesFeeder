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

Search for a show in the first input box. The link to the RSS feed is on the right of every search result. Each episode in the RSS feed links to a Google search of the show and its episode. If you want to have further search terms, you can add them in the second input box prior to copying the link to the RSS feed.
