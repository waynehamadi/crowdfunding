require 'rails_helper'
RSpec.describe VerifyPayment, type: :transactions do
  subject {VerifyPayment.new.call(contribution: contribution)}
  let(:contribution) { FactoryBot.create(:contribution) }
  before(:each) do
    CreateContribution.new.call(contribution: contribution )
  end

  context 'When MangoPay sends back a succeed status' do
    before(:each) do
      allow(MangoPay::PayIn).to receive(:fetch).and_return({"Status" => 'SUCCEEDED'})
    end
    it 'the transaction succeeds' do
      expect(subject).to be_success
    end

    it 'calls MangoPay::PayIn' do
      expect(MangoPay::PayIn).to receive(:fetch).and_call_original
      subject
    end
    it 'changes aasm_sate to paid' do
      allow(MangoPay::PayIn).to receive(:fetch).and_return({"Status" => 'SUCCEEDED'})

      expect { subject }.to change(contribution, :aasm_state).from('payment_pending').to('paid')

    end

  context 'When MangoPay does not send back a succeed status' do
    before(:each) do
      allow(MangoPay::PayIn).to receive(:fetch).and_return({"Status" => 'Other_Status'})
    end
    it 'the transaction should fail' do
      expect(subject).to be_failure
    end
    it 'calls MangoPay::PayIn' do
      expect(MangoPay::PayIn).to receive(:fetch).and_call_original
      subject
    end
    it 'changes aasm_sate to canceled' do
      expect { subject }.to change(contribution, :aasm_state).from('payment_pending').to('canceled')
      subject
    end
  end
  end
end
