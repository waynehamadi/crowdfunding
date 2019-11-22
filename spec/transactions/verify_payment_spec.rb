require 'rails_helper'
RSpec.describe VerifyPayment, type: :transactions do
  subject {VerifyPayment.new.call(contribution: contribution)}
  let(:contribution) { Contribution.create(aasm_state: "payment_pending") }

  context 'When MangoPay sends back a succeed status' do
    before(:each) do
      allow(MangoPay::PayIn).to receive(:fetch).and_return({"Status" => 'SUCCEEDED'})
    end

    it 'the transaction succeeds' do
      expect(subject).to be_success
    end

    it 'changes aasm_sate to paid' do
      expect { subject }.to change(contribution, :aasm_state).to('paid')
    end

  context 'When MangoPay does not send back a succeed status' do
    before(:each) do
      allow(MangoPay::PayIn).to receive(:fetch).and_return({"Status" => 'Other_Status'})
    end

    it 'the transaction should fail' do
      expect(subject).to be_failure
    end

    it 'changes aasm_sate to canceled' do
      expect { subject }.to change(contribution, :aasm_state).to('canceled')
    end
  end
  end
end
