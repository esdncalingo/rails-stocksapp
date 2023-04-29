require 'rails_helper'

RSpec.describe UtilitiesHelper, type: :helper do
  it 'run random emoji' do
    expect(random_emoji).should_not be_nil
  end
end
