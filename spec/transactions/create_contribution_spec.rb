# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CreateContribution, type: :transaction do
  subject { CreateContribution.new.call(contribution: contribution) }
  context 'when contribution is valid', cassette: :mangoPay_payin_card_ok do
    let(:contribution) { FactoryBot.create(:contribution) }

    it 'returns success' do
      expect(subject).to be_success
    end

    it 'returns a redirect_url' do
      expect(subject.success[:redirect]).not_to be(nil)
    end

    it 'calls MangoPay::PayIn::Card::Web' do
      expect(MangoPay::PayIn::Card::Web).to receive(:create).and_call_original
      subject
    end

    it 'change state to payment_pending' do
      expect { subject }.to change(contribution, :aasm_state).from('created').to('payment_pending')
    end
  end

  context 'when contribution amount is 0', cassette: :mangoPay_payin_card_failed do
    let(:contribution) { FactoryBot.create(:contribution, amount_in_cents: 0) }
    it 'returns failure' do
      expect(subject).to be_failure
    end

    it 'calls MangoPay::PayIn::Card::Web' do
      expect(MangoPay::PayIn::Card::Web).to receive(:create).and_call_original
      subject
    end

    it 'does not change state' do
      expect { subject }.not_to change(contribution, :aasm_state)
    end
  end
end
