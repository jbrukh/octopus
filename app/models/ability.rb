class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Experiment
  end
end
