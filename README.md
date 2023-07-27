# Weather forecast

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/kuldeepaggarwal/weather_forecast/tree/main.svg?style=svg&circle-token=eb7bbd9a7e13f039ecccc4a51579584b3d16a159)](https://dl.circleci.com/status-badge/redirect/gh/kuldeepaggarwal/weather_forecast/tree/main)

It is a simple application to show weather for a specified address.

## Requirements:

- Ruby 3.2.2
- Bundler gem(`gem install bundler`)
- Set `WEATHER_API_ACCESS_ID` environment variable with [WeatherAPI](https://www.weatherapi.com/) API key

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

## Playgroud via rails console

We can play with weather forcast APIs by opening a rails console using the following command in the terminal.

```sh
WEATHER_API_ACCESS_ID=<api_key> bundle exec rails c
```

and then you can search the weather report with the following API interface:

```rb
WeatherApi.fetch_weather_report(address: 'Milton, Canada, L9T5J7')
```

## Test

1. run `bundle exec rspec spec`
