class OrdersController < ApplicationController
  require "json"
  require "net/http"
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
    @cot = {"id_orden" => @order.id, "material" => @mat.nombre, "cantidad" => @MO.cant}
    @cot2 = [["id_orden", @order.id], ["material", @mat.nombre], ["cantidad", @MO.cant]]
    puts @cot
    begin
      uri = URI("http://localhost:3004/cotizaciones")
      http = Net::HTTP.new(uri.hostname, uri.port)
      uri_query = URI.encode_www_form(@cot2)
      req = Net::HTTP::Post.new(uri.path, init_header = {'Content-Type' =>'application/json',
            'Authorization' => 'XXXXXXXXXXXXXXXX'})
      req.body = @cot.to_json
      puts req.body
      res = http.request(req)
      puts "response #{res.body}"
      puts JSON.parse(res.body)
      @order.estado = "En cotizacion"
      @order.save
      flash[:success] = "Cotizacion de orden #{@order.id} enviada a Laudus* con exito."
      render "list_orders"
    rescue =>e
      puts "failed #{e}"
    end
  end

  def presupuestos
    uri = URI('http://localhost:3004/orders/')
  end


  def order_params
    params.require(:order).permit(:fecha_entrega, :direccion, :estado, :cant, :materials, :bodega)
  end

  def update_params
    params.require(:order).permit(:estado)
  end



end
