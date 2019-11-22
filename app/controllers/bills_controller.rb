class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])

    respond_to do |format|
    format.html
      format.pdf do
        render pdf: 'billing'
      end
    end
  end
end
