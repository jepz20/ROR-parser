
# ROR PARSER

Parse and extract the content from the h1, h2, h3 and links from a url

## Ruby version
  Ruby Version 2.1, Rails 4.2.6

## Database initialization
  run `rake db:migrate` to initialize the database

## Endpoints

### [GET] pages
returns a list parse pages with the content detail

### [POST] pages
params: url
```
{"page":{"url":"http://example.com"}}
```
parse the content and save the page content. returns the parsed content.
