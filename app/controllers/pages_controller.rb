class PagesController < ApplicationController


  def join_us
  end

  def sign_in
  end

  def sign_up
  end

  def about_us
  end

  def privacy_policy
    render(layout: !request.xhr?)
  end

  def terms_of_service
    render(layout: !request.xhr?)
  end

  def rules_of_action
    render(layout: !request.xhr?)
  end

  def app_links
  end

end
