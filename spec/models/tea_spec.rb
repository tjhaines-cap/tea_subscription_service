require 'rails_helper'

RSpec.describe Tea do
  describe 'assocations' do
    it { should have_many :subscriptions}
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :temperature }
    it { should validate_presence_of :brew_time }
  end

end