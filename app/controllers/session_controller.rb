class SessionController < ApplicationController

  def create
    if params[:email].present? && params[:password].present?
      @current_user = User.new(email: params[:email], password: params[:password])
      @current_user.sign_in
      if @current_user.valid?
        flash[:notice] = "Sie sind erfolgreich angemeldet"
        session["current_user"] = {}
        session["current_user"]["email"] = @current_user.email
        session["current_user"]["authentication_token"] = @current_user.authentication_token
        session["current_user"]["applications"] = @current_user.applications
        redirect_to root_path()
      else
        flash[:error] = "E-Mail oder Passwort ist falsch"
        redirect_to log_in_path()
      end
    end
  end

  def destroy
    session.destroy
    flash[:notice] = "You have been successfully logged off"
    redirect_to root_path()
  end
end
