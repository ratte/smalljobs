# coding: UTF-8

require_relative '../../../spec_helper'

feature 'Logout' do

  let(:org) { Fabricate(:org_lenzburg) }
  let(:region) { org.regions.first }

  let(:provider) do
    Fabricate(:provider,
              email: 'rolf@example.com',
              password: 'tester1234',
              password_confirmation: 'tester1234',
              place: region.places.first)
  end

  background do
    login_as(provider, scope: :provider)
  end

  scenario 'Successfully log out' do
    visit_on region, '/provider/dashboard'
    click_on 'Abmelden'

    within_notifications do
      expect(page).to have_content('Erfolgreich abgemeldet.')
    end
  end
end
