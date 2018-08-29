class OrdersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user

  def new
    @order = Order.new()
    @lista_materiales = Material.all
    @orders_material = @order.materials.build
  end

  def create
    @material = Material.find_by(id: order_params["materials"])
    @order = Order.new(order_params)
    puts @order.direccion
    @order.estado = "Pendiente"

    puts order_params
    @order.materials << order_params["materials"]

    if @order.save
      redirect_to "/home"
    else
      flash[:danger] = "Solicitud invalida"
      render "new"
    end
  end

  def order_params
    params.require(:order).permit(:fecha_entrega, :direccion, :estado, :materials)
  end

end
