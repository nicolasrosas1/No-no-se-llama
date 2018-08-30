class OrdersController < ApplicationController
  require "json"
  require "net/http"
  include SessionsHelper
  include HomeHelper

  before_action :logged_in_user, :iniciar

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

  def show
    @order = Order.find_by(id: params[:id])
    @MO = MaterialsOrder.find_by(order_id: @order.id)
    @mat = Material.find_by(id: MaterialsOrder.find_by(order_id: @order.id).material_id)
  end

  def update
    @order = Order.find_by(id: params[:id])
    @MO = MaterialsOrder.find_by(order_id: @order.id)
    @mat = Material.find_by(id: MaterialsOrder.find_by(order_id: @order.id).material_id)

    if @order.estado == "Falta Material"
      @order.update_attributes(update_params)
      @MO.cant = @MO.cant - @mat.stock
      @MO.save
      @mat.stock = 0
      @mat.save
    elsif @order.estado == "En despacho"
      @mat.stock = @mat.stock - @MO.cant
      if @mat.stock < 0
        flash[:danger] = "No hay material suficiente"
        render "new"
      else
        @order.update_attributes(update_params)
        @MO.cant = 0
        @MO.save
      end
    else
      @order.update_attributes(update_params)
    end
    redirect_to '/list_orders'
  end

  def cotizar
    @order = Order.find_by(id: params[:id])
    @MO = MaterialsOrder.find_by(order_id: @order.id)
    @mat = Material.find_by(id: MaterialsOrder.find_by(order_id: @order.id).material_id)
    @cot = {"id_orden" => @order.id, "material" => @mat.id, "cantidad" => @MO.cant}
    begin
      uri = URI("http://localhost:3004/cotizaciones")
      http = Net::HTTP.new(uri.hostname, uri.port)
      req = Net::HTTP::Post.new(uri.path, init_header = {'Content-Type' =>'application/json',
            'Authorization' => 'XXXXXXXXXXXXXXXX'})
      puts "res"
      req.body = @cot.to_json
      puts req.body

      res = http.request(req)
      puts JSON.parse(res.body)
      @order.estado = "En cotizacion"
      @order.save
      flash[:success] = "Cotizacion de orden #{@order.id} enviada a Laudus* con exito."
      render "list_orders"
    rescue =>e
      puts "failed #{e}"
    end
  end

  def presupuestonew
    @order = Order.find_by(id: params[:id])
    @MO = MaterialsOrder.find_by(order_id: @order.id)
    @mat = Material.find_by(id: MaterialsOrder.find_by(order_id: @order.id).material_id)
  end

  def presupuesto
    @order = Order.find_by(id: params[:id])
    @order2 = Order.new(order_params)
    @MO = MaterialsOrder.find_by(order_id: @order.id)
    @mat = Material.find_by(id: MaterialsOrder.find_by(order_id: @order.id).material_id)
    @cot = {"id_orden" => @order.id, "precio" => @order2.precio}
    begin
      uri = URI("http://localhost:3004/presupuestos")
      http = Net::HTTP.new(uri.hostname, uri.port)
      req = Net::HTTP::Post.new(uri.path, init_header = {'Content-Type' =>'application/json',
            'Authorization' => 'XXXXXXXXXXXXXXXX'})
      puts "res"
      req.body = @cot.to_json
      puts req.body

      res = http.request(req)
      puts JSON.parse(res.body)
      @order.estado = "Cotizada"
      @order.save
      flash[:success] = "Presupuesto de orden #{@order.id} enviada a Laudus* con exito."
      render "list_orders"
    rescue =>e
      puts "failed #{e}"
    end
  end

  def order_params
    params.require(:order).permit(:fecha_entrega, :direccion, :estado, :cant, :materials, :bodega, :precio)
  end

  def update_params
    params.require(:order).permit(:estado)
  end



end
