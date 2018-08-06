class MaterialsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user
  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    if @material.save
      flash[:notice] = "Material registrado"
      flash[:color]= "valid"
    else
      flash[:notice] = "Formulario invalido"
      flash[:color]= "invalid"
    end
    render "new"
  end

  def material_params
    params.require(:material).permit(:nombre, :precio, :stock)
  end

  def list_materials
    @lista_materiales = Material.all
  end

end
