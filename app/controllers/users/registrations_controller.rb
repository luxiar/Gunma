# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  def new
    authorize! :create, User
    super
  end

  def create
    authorize! :create, User
    super
  end

  def edit
    authorize! :update, User
    super
  end

  def update
    authorize! :update, User
    super
  end

  def destroy
    authorize! :destroy, User
    super
  end
end
