require 'spec_helper'

describe Participant do
  context 'in general' do
    it { should belong_to(:user) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:birthday) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:gender) }
    it { should ensure_inclusion_of(:gender).in_array(['m', 'f']) }

    it 'has unique email' do
      existing = create :participant
      duplicate = build :participant
      expect(duplicate.valid?).to eq(false)
      expect(duplicate.error_on(:email).length).to eq(1)
    end
  end
end
