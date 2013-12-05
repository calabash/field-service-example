Given /^I am on the Assignments screen$/ do

  user = USERS[:nat]
  @page = page(Login).await().login(user)

  unless @page.is_a?(Assignments)
    raise "Expected login as #{user} to transition to Assignments"
  end
end




When(/^I start recording on \#(\d+)$/) do |assignment|

  @page.tap_record_for_assignment(:number => assignment)

  sleep(3) #we want a screenshot after 3 seconds

  screenshot_embed(:label => 'Recording')

end




Then /^the timer should start ticking$/ do

  wait_for(:timeout => 10,
           :retry_frequency => 0.5) do
    time = @page.current_timer_time
    $stdout.write '.'
    h,m,s = time.split(':')
    s.to_i>=5
  end
  $stdout.flush

end




Then /^I should see assignment #(\d+) titled "([^"]*)" as active$/ do |assignment_no, assignment_title|

  @page.assert_assignment({:number => assignment_no, :title => assignment_title, :status => :active})

end

When /^I tap assignment #(\d+)$/ do |assignment_no|

  @page.tap_assignment(:number => assignment_no)

end

