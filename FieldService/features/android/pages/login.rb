require 'calabash-android/abase'

class Login < Calabash::ABase
  include FieldService::AndroidHelpers

  def trait
    "button marked:'Log In'"
  end


  def login(user)

    enter_text(username_field(), user[:email])
    enter_text(password_field(), user[:password], :wait_for_keyboard => false)

    touch(login_button)

    assignments = page(Assignments)

    begin
      assignments.await(:timeout => 20)
    rescue
      self
    end

  end

  def login_button
    trait
  end



  def username_field
    "EditText id:'userName'"
  end

  def password_field
    "EditText id:'password'"
  end


end