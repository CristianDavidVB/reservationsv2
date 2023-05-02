class RestaurantFinder
  def call(params)
    scoped = initial_scope
    scoped = scoped.where("name like ?", "#{params[:name]}%") if params[:name].present?
    scoped = scoped.where(city: params[:city]) if params[:city].present?
    scoped
  end
  def initial_scope
    Restaurant.all
  end
end