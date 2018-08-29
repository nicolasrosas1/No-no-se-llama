class MaterialsController < ApplicationController
  require "json"
  include SessionsHelper
  include MaterialsHelper
  before_action :logged_in_user
  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    if @material.save
      flash[:success] = "Material registrado"
      @lista_materiales = Material.all
      @MW = MaterialsWarehouse.new(:warehouse_id => material_params["bodega"], :material_id => Material.last.id)
      @prev_view = "new_material"   #esto acabo de arreglar
      render "list_materials"
    else
      render "new"
    end

  end

  def material_params
    params.require(:material).permit(:nombre, :precio, :stock, :bodega)
  end

end
