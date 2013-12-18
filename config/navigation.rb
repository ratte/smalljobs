SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = SimpleNavigationRenderers::Bootstrap2

  navigation.items do |primary|
    if job_broker_signed_in?
      primary.item :dashboard, { icon: 'fa fa-dashboard', text: I18n.t('navigation.dashboard') }, job_brokers_dashboard_path
      primary.item :profile,   { icon: 'fa fa-user', text: I18n.t('navigation.profile') }, edit_job_broker_registration_path
      primary.item :sign_out,  { icon: 'fa fa-sign-out', text: I18n.t('navigation.sign_out') }, destroy_job_broker_session_path, method: :delete

    elsif job_provider_signed_in?
      primary.item :dashboard, { icon: 'fa fa-dashboard', text: I18n.t('navigation.dashboard') }, job_providers_dashboard_path
      primary.item :profile,   { icon: 'fa fa-user', text: I18n.t('navigation.profile') }, edit_job_provider_registration_path
      primary.item :sign_out,  { icon: 'fa fa-sign-out', text: I18n.t('navigation.sign_out') }, destroy_job_provider_session_path, method: :delete

    elsif job_seeker_signed_in?
      primary.item :dashboard, { icon: 'fa fa-dashboard', text: I18n.t('navigation.dashboard') }, job_seekers_dashboard_path
      primary.item :profile,   { icon: 'fa fa-user', text: I18n.t('navigation.profile') }, edit_job_seeker_registration_path
      primary.item :sign_out,  { icon: 'fa fa-sign-out', text: I18n.t('navigation.sign_out') }, destroy_job_seeker_session_path, method: :delete

    else
      primary.item :registration, { icon: 'fa fa-user', text: I18n.t('navigation.sign_up') }, root_path
      primary.item :sign_in,      { icon: 'fa fa-sign-in', text: I18n.t('navigation.sign_in') }, sign_in_path
    end

    primary.dom_class = 'nav-pills pull-right'
  end
end
