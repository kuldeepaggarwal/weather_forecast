# frozen_string_literal: true

class WelcomeComponent < ViewComponent::Base
  def initialize(user:)
    super()
    @user = user
  end
end
