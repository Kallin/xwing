# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'with users and roles' do
  # def log_in_as(user)
  #   visit new_user_session_path
  #   fill_in('user_email', with: user.email)
  #   fill_in('user_password', with: user.password)
  #   click_button('Log in')
  #   sleep 0.1
  # end

  # let(:user) { User.create(email: 'test@example.com', password: 'password') }

  it 'allows a logged-in user to view the collections index page' do
    # log_in_as(user)
    sign_in(create(:user))
    visit(collection_path)
    expect(page).to have_current_path(collection_path, ignore_query: true)
  end

  it 'does not allow a user to see the project page if not logged in' do
    visit(collection_path)
    expect(page).to have_current_path(user_session_path, ignore_query: true)
  end
end
