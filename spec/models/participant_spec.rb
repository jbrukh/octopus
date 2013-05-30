require 'spec_helper'

describe Participant do
  fixtures :users

  describe 'in general' do
    it { should belong_to(:user) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:birthday) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:gender) }
    it { should ensure_inclusion_of(:gender).in_array(['m', 'f']) }

    it { should strip_attribute(:first_name) }
    it { should strip_attribute(:last_name) }
    it { should strip_attribute(:email) }

    it 'has unique email' do
      existing = create :participant, :user => users(:user)
      duplicate = build :participant
      expect(duplicate.valid?).to eq(false)
      expect(duplicate.error_on(:email).length).to eq(1)
    end
  end

  describe '#search' do
    let!(:participant) do
      create :participant, :user => users(:user),
        :first_name => 'Kevin',
        :last_name => 'Jones',
        :email => 'kevin@example.com'
    end

    it 'searches on first name' do
      expect(Participant.search('kevin').length).to eq(1)
    end

    it 'searches on last name' do
      expect(Participant.search('jones').length).to eq(1)
    end

    it 'searches on email' do
      expect(Participant.search('KEVIN@example.com').length).to eq(1)
    end

    it 'matches partial email' do
      expect(Participant.search('example.com').length).to eq(1)
    end
  end
end
