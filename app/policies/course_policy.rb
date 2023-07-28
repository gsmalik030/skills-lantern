class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  
  def edit?
    @record.user == @user
  end

  def show?
    @record.is_published? && @record.is_approved || @user.present? && @user.has_role?(:admin) || @record.user == @user || @user.present? && @record.enrolled(@user)
  end

  def approve?
    @user.has_role?:admin
  end

  def unapprove?
    @user.has_role?:admin
  end

  def update?
    @record.user == @user
  end

  def new?
    @user.has_role?:teacher
  end

  def create?
    @user.has_role?:teacher
  end

  def destroy?
    (@user.has_role?:admin || @record.user == @user) && @record.enrollments.empty? 
  end
end