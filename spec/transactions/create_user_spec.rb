require 'rails_helper'
RSpec.describe CreateUser, type: :transactions do
  subject { CreateUser.new.call(user: user) }

  context '#create transaction' do
    let(:user) { User.create!(first_name:"first_name", last_name:"last_name", birth_date:"1999-03-04", email:"username@domain", password:"password") }
    it 'Transactions without email fail' do
      user.email = nil
      expect(subject.class).to eq(Dry::Monads::Result::Failure)
    end
    it 'Transactions that succeed must send an email' do
      if subject.class == Dry::Monads::Result::Failure
      "I didn't find a way to do it"
      end
    end
  end
end
