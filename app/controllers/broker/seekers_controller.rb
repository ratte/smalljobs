class Broker::SeekersController < InheritedResources::Base

  before_filter :authenticate_broker!
  before_filter :optional_password, only: [:update]

  load_and_authorize_resource :seeker, through: :current_broker

  protected

  def optional_password
    if params[:seeker][:password].blank?
      params[:seeker].delete(:password)
      params[:seeker].delete(:password_confirmation)
    end
  end

  def permitted_params
    params.permit(seeker: [:id, :password, :password_confirmation, :firstname, :lastname, :street, :zip, :city, :email, :phone, :mobile, :date_of_birth, :contact_preference, :contact_availability, :active, :confirmed, work_category_ids: []])
  end

end
