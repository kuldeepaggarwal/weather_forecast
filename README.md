# Weather forecast

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/kuldeepaggarwal/weather_forecast/tree/main.svg?style=svg&circle-token=eb7bbd9a7e13f039ecccc4a51579584b3d16a159)](https://dl.circleci.com/status-badge/redirect/gh/kuldeepaggarwal/weather_forecast/tree/main)

It is a simple application to show weather for a specified address.

## Demo

https://github.com/kuldeepaggarwal/weather_forecast/assets/1930730/d933ceab-976d-47a4-b793-b79fb1df9197


## Requirements:

- Ruby 3.2.2
- Bundler gem(`gem install bundler`)
- Set `WEATHER_API_ACCESS_ID` environment variable with [WeatherAPI](https://www.weatherapi.com/) API key

## Setup

1. clone the project
2. Execute the following command in the terminal `cd weather_forcast && ./bin/setup`

## Lint

We are using [Rubocop](https://github.com/rubocop/rubocop) gem to validate the style for this project.

The following command will check for any linting issue:

```
bundle exec rubocop
```

## Start the server

1. Run the server by the following command:
    `WEATHER_API_ACCESS_ID=<api_key> bundle exec rails s`
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

## Technical Decisions

1. ViewComponents: A framework for creating reusable, testable & encapsulated view components, built to integrate seamlessly with Ruby on Rails.

2. Formatters: These are the response massagers that convert raw response from a very specific API to our business logic objects. This is very helpful if we change the API client or use any other weather API anywhere in the application, then we just need to add more formatters in the `app/formatters` folder.

## Improvements

1. Structure / architecture:
   - Lib services can be extracted out into a suitable gem.
2. Forecasted data can be shown.
3. Allow user to select the units in which they want to see the temperature.
4. Have one field for the complete address in the form and a parser to parse the address from the string.


## Questions?

Q1: Do we need to cache by only postal code?

A: May be not, because multiple countries have same postal code. For instance: swedish zip code 26140 exists in US, Spain, France and Ukraine.
