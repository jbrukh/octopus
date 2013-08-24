class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Experiment

    can :read, Recording do |recording|
      # we can read our own recordings and all the recordings
      # which were created by anyone in our organization
      recording.user_id == user.id || recording.user.organization_id == user.organization_id
    end

    can :update, Recording do |recording|
      recording.user_id == user.id
    end

    can :destroy, Recording do |recording|
      recording.user_id == user.id
    end

    can :read, Participant do |recording|
      # we can read our own recordings and all the recordings
      # which were created by anyone in our organization
      recording.user_id == user.id || recording.user.organization_id == user.organization_id
    end

    can :update, Participant do |recording|
      recording.user_id == user.id
    end

    can :destroy, Participant do |recording|
      recording.user_id == user.id
    end
  end
end
