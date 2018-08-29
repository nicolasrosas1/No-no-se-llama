class WarehousesController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user

  def new
    @warehouse = Warehouse.new()
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      flash[:success] = "Bodega registrada"
      else
        render "new"
      end
  end

  def show
    @warehouse = Warehouse.find_by(id: params[:id])
    puts @warehouse.id
  end

  def warehouse_params
    params.require(:warehouse).permit(:nombre, :direccion)
  end
end
