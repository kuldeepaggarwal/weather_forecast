# frozen_string_literal: true

Weather = Struct.new(:updated_at, :temperature_in_celcius, :temperature_in_fahrenheit, keyword_init: true)
