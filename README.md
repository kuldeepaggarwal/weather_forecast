# Weather forecast

It is a simple application to show weather for a specified address.

## Requirements:

- Ruby 3.2.2
- Bundler gem(`gem install bundler`)

## Setup

1. clone the project
2. Execute the following command in the terminal `cd weather_forcast && bundle install`

## Lint

We are using [Rubocop](https://github.com/rubocop/rubocop) gem to validate the style for this project.

The following command will check for any linting issue:

```
bundle exec rubocop
```

## Start the server

1. Run the server by the following command:
    `bundle exec rails s`
2. Visit `http://localhost:3000` in the browser and play with the solution.

## Test

1. run `bundle exec rspec spec`