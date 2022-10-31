class ListsController < ApplicationController
  before_action :set_list, only: %i[edit destroy update move_up move_down]
  def index
    if user_signed_in?
      @lists = current_user.lists.order(:number)
    else
      redirect_to root_url
    end
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to lists_url
    else
      flash[:alert] = '請輸入清單名稱'
      redirect_to new_list_url
    end
  end

  def edit; end

  def update
    if @list.update(list_params)
      flash[:notice] = '清單名稱更新成功'
      redirect_to lists_url
    else
      render action: :edit
    end
  end

  def destroy
    @list.destroy
    flash[:alert] = '刪除清單'
    redirect_to lists_url
  end

  def move_up
    begin
      @list.move_up_number
    rescue StandardError
      flash[:alert] = '向上移動失敗'
    end
    redirect_to lists_url
  end

  def move_down
    begin
      @list.move_down_number
    rescue StandardError
      flash[:alert] = '向下移動失敗'
    end
    redirect_to lists_url
  end

  private

    def list_params
      params.require(:list).permit(:name)
    end

    def set_list
      @list = List.find(params[:id])
    end
end
