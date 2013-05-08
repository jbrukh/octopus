class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Theory
  end
end
