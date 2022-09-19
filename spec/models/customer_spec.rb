require 'rails_helper'

RSpec.describe Customer do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :address }
  
  it { should validate_uniqueness_of :email }
end