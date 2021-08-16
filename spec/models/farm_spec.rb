# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Farm, type: :model do
  describe 'asssociations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:size) }
    it { is_expected.to validate_presence_of(:farm_yield) }
  end
end
