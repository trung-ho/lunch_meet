class RestaurantsControllerPolicy
  attr_reader :user, :ctrlr

  def initialize(user, ctrlr)
    @user = user
    @ctrlr = ctrlr
  end

  def edit?
    byebug
    true
  end
end