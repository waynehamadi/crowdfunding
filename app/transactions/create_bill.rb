class CreateBill
  include Dry::Transaction
  step :init_bill

  private

  def init_bill(input)
    @content = input[:content]
    @amount = @content['DeclaredDebitedFunds']['Amount'].to_i.fdiv(100).round
    @fees = @content['DeclaredFees']['Amount'].to_i
    @currency = @content['DeclaredDebitedFunds']['Currency']
    @bic = @content['BankAccount']['BIC']
    @iban = @content['BankAccount']['IBAN']
    @ref = @content['WireReference']
    @date = DateTime.strptime((@content['CreationDate']).to_s,'%s').strftime("%A, %-d %B %y:%d")
    Success(input.merge(
              amount: @amount,
              fees: @fees,
              currency: @currency,
              bic:  @bic,
              iban: @iban,
              ref: @ref,
              date: @date,
              content: @content
            ))
  end
end
      t.integer :amount
      t.integer :fees
      t.string :bic
      t.string :iban
      t.string :ref
      t.date :date
      t.string :currency
