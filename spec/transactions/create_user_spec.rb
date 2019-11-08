require 'rails_helper'
RSpec.describe CreateUser, type: :transactions do
  subject { CreateUser.new.call(user: user) }

  context '#create transaction' do
    let(:user) { User.create!(first_name:"first_name", last_name:"last_name", birth_date:"1999-03-04", email:"username@domain", password:"password") }
    context 'Given the email is nil' do
      before do
        user.email = nil
      end
      it 'the transaction should fail' do
        expect(subject).to be_failure
      end
    end
  end
end
