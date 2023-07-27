# frozen_string_literal: true

class GuestUser
  attr_reader :name

  def initialize
    @name = 'Guest'
  end
end
