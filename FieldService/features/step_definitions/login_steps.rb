
Given /^I am on the Login screen$/ do

  @page = page(Login).await()

end

When /^I login as "([^"]*)"$/ do |user_str|

  user = USERS[user_str.downcase.to_sym]

  #noinspection RubyResolve

  @page = @page.login(user)

end

Then /^I should go to the Assignments screen$/ do
  #noinspection RubyResolve

  unless @page.is_a?(Assignments)
    raise "Expected AssignmentsScreen but was #{@page && @page.class}"
  end

end

Then /^I should not be logged in$/ do
  #noinspection RubyResolve

  unless @page.is_a?(Login)
    raise "Expected LoginScreen but was #{@page && @page.class}"
  end

end

And /^I should see a login error message$/ do
  @page.assert_login_error_message
end