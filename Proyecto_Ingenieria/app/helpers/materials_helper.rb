module MaterialsHelper
  def list_materials
    @lista_materiales = Material.all
  end
end
