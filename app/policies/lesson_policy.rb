class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  
  def edit?
    @record.course.user = @user
  end

  def update?
    @record.course.user = @user
  end

  def new?
    @record.course.user = @user
  end

  def show?
    @record.course.user = @user || @record.course.user.has_role?(:admin)
  end

  def create?
    @record.course.user = @user
  end

  def destroy?
    @record.course.user = @user
  end
end