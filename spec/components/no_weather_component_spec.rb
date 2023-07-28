# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NoWeatherComponent, type: :component do
  it 'renders content when weather report is not found for a given location' do
    render_inline(described_class.new)

    expect(page).to have_content('No weather report found for the location!')
  end
end
