# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeComponent, type: :component do
  let(:user) { instance_double(GuestUser, name: 'Kuldeep') }

  it 'renders welcome user information' do
    render_inline(described_class.new(user:))

    expect(page).to have_css('div.center', text: 'Hi Kuldeep! Welcome to weather forecast.')
  end
end
