require 'rails_helper'
RSpec.describe CreateUser, type: :transactions do
  subject { CreateUser.new.call(user: user) }
  let(:user) { User.create!(first_name:"first_name", last_name:"last_name", birthday:"1999-03-04", email:"user_457@capsens.eu", password:"password", country_of_residence: "FR", nationality: "FR") }
  context 'Given the email is nil' do
    before do
      user.email = nil
    end
    it 'the transaction should fail' do
      expect(subject).to be_failure
    end
  end
  context 'when user is valid' do

    it 'calls MangoPay::NaturalUser' do
      expect(MangoPay::NaturalUser).to receive(:create).and_call_original
      subject
    end

    it 'callsMangoPay::Wallet' do
      expect(MangoPay::Wallet).to receive(:create).and_call_original
      subject
    end
  end

  context 'when nationality is not specified' do
    let(:user) { User.create!(first_name:"first_name", last_name:"last_name", birthday:"1999-03-04", email:"user_457@capsens.eu", password:"password", country_of_residence: "FR", nationality: "") }
    it 'returns failure' do
      expect(subject).to be_failure
      subject
    end

    it 'calls MangoPay::NaturalUser' do
      expect(MangoPay::NaturalUser).to receive(:create).and_call_original
      subject
    end
    it 'does not call MangoPay::Wallet' do
      expect(MangoPay::Wallet).not_to receive(:create).and_call_original
      subject
    end

    it 'does not create mango_pay_id' do
      expect { subject }.not_to change(user, :mango_pay_id)
      subject
    end
    it 'does not create wallet_id' do
      expect { subject }.not_to change(user, :wallet_id)
      subject
    end
  end
  end

