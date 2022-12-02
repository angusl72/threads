class SellerReviewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def edit?
    true
  end

  def update?
    true
    # record.user == user
    # record: the item passed to the `authorize` method in controller
    # user: the `current_user` signed in with Devise
  end

end
