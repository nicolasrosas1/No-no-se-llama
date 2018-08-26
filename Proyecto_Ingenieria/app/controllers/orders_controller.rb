class OrdersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user

  def new
    @order = Order.new()
    @lista_materiales = Material.all
    puts @lista_materiales
    @orders_material = @order.materials.build
  end

  def create
    @order = Order.new(order_params)
    @order.estado = "Pendiente"


    puts order_params
    @order.materials << order_params["materials"]
    # order_params["materials"].each do |material|
    #   puts material
    #   if !material.empty?
    #     @author.orders_materials.build(:orders_id => material)
    #   end
    # end

    if @order.save
      redirect_to "/home"
    else
      flash[:notice] = "Solicitud invalida"
      flash[:color]= "invalid"
      render "new"
    end
  end

  def order_params
    params.require(:order).permit(:fecha_entrega, :direccion, :estado,materials: :id)
  end

end
