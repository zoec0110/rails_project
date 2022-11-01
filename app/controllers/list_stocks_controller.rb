class ListStocksController < ApplicationController
  before_action :find_list

  def index
    @stocks = @list.stocks
    @stock = Stock.new
  end

  def create
    if Stock.find_by(stock_params)
      @stock = Stock.find_by(stock_params)
      @list.stocks << @stock
      redirect_to lists_url
    else
      flash[:alert] = '此股號不存在'
      redirect_to list_stocks_url(@list.id)
    end
  end

  def destroy
    @list.stocks.destroy(Stock.find(params[:id]))
    redirect_to lists_url
  end

  private

    def find_list
      @list = current_user.lists.find(params[:list_id])
    end

    def stock_params
      params.require(:stock).permit(:stock_symbol)
    end
end
