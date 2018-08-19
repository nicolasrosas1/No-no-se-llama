class OrdersController < ApplicationController
  before_action :init
  def init
    self.estado = "Pendiente"
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "Solicitud enviada"
      flash[:color]= "valid"
    else
      flash[:notice] = "Solicitud invalida"
      flash[:color]= "invalid"
    end
    render "new"


  end

  def order_params
    params.require(:order).permit(:fecha_entrega, :direccion, :estado)
  end

end
