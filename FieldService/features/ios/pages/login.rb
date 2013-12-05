require 'calabash-cucumber/ibase'

class Login < Calabash::IBase
  include FieldService::IOSHelpers

  def trait
    "button marked:'Log In'"
  end

  def login(user)

    enter_text(username_field(), user[:email])
    enter_text(password_field(), user[:password], :wait_for_keyboard => false)
    touch(login_button)

    wait_for_elements_do_not_exist(['activityIndicatorView'], :timeout => 30)

    assignments = page(Assignments)

    begin
      assignments.await
    rescue
      self
    end

  end

  def username_field
    "textField placeholder:'Username'"
  end

  def password_field
    "textField placeholder:'Password'"
  end

  def login_button
    trait
  end


end