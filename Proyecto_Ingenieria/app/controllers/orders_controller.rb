class OrdersController < ApplicationController
  require "json"
  include SessionsHelper
  before_action :logged_in_user

  def new
    @order = Order.new()
    @lista_materiales = Material.all
  end

  def create
    @order = Order.new(order_params)
    @order.estado = "Pendiente"
    puts order_params["materials"]
    if @order.save
      @last = Order.last.id
      # order_params["materials"].each do |m|
      @OM = MaterialsOrder.new(:order_id => @last, :material_id => order_params["materials"], :cant => order_params["cant"])
      @OM.save
      # end
      redirect_to "/home"
    else
      flash[:danger] = "Solicitud invalida"
      render "new"
    end
  end

  def order_params
    params.require(:order).permit(:fecha_entrega, :direccion, :estado, :cant, :materials, :bodega)
  end

end
