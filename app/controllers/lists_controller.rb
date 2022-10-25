class ListsController < ApplicationController
  before_action :set_list, only: %i[edit destroy update move_up move_down]
  # before_action :find_user, only: %i[create index]
  def index
    @lists = current_user.lists.order(:number)
    # @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
    @list.add_order
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
    @list.move_up_number
    redirect_to root_url
  end

  def move_down
    @list.move_down_number
    redirect_to root_url
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
