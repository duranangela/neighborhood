require 'rails_helper'

describe User, type: :model do
  context 'relationships' do
    it {should have_many :projects}
    it {should belong_to :district}
  end

  context 'verifications' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :district_id}
    it {should validate_presence_of :email}
  end
end
