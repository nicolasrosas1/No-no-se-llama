class OrdersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user

  def new
    @order = Order.new()
    @lista_materiales = Material.all
    puts @lista_materiales
    @orders_material = @order.materials.build
    @@cantidad = 1
  end

  def create
    @material = Material.find_by(id: order_params["materials"])
    @order = Order.new(order_params)

    @order.estado = "Pendiente"

    puts order_params
    @order.materials << Material.find_by(order_params["materials"])

    if @order.save
      redirect_to "/home"
    else
      flash[:danger] = "Solicitud invalida"
      render "new"
    end
  end

  def order_params
    params.require(:order).permit(:fecha_entrega, :direccion, :estado)
  end

end
