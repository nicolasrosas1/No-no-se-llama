module MaterialsHelper
  def list_materials
    @lista_materiales = Material.where(["nombre LIKE ?", "%#{params[:search]}%"])
  end
end
