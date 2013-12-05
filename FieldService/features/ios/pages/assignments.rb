require 'calabash-cucumber/ibase'

class Assignments < Calabash::IBase

  def trait
    "navigationItemView marked:'Assignments'"
  end

  def await(wait_opts={})
    super(wait_opts)
    wait_for_none_animating
    wait_for(timeout: 10) do
      element_exists("button marked:'record'") ||
        element_exists("button marked:'record active'")
    end
    self
  end

  def current_screen?
    element_exists(trait)
  end

  def tap_assignment(assignment)
    touch(assignment_query(assignment))
  end

  def tap_record_for_assignment(assignment)

    touch("#{assignment_query(assignment)} sibling button marked:'record'")

  end

  def assignment_query(assignment)
    "label {text BEGINSWITH '\##{assignment[:number]}'}"
  end

  def wait_for_assignment_details
    wait_for_elements_exist(["navigationItemView marked:'#2001 Xamarin'"])
    wait_for_none_animating
  end

  def current_timer_time
    start_record_button_q = "button marked:'record'"
    end_record_button_q = "button marked:'record active'"
    if element_exists(start_record_button_q)
      button_q = start_record_button_q
    else
      button_q = end_record_button_q
    end
    query("#{button_q} sibling label", :text).last
  end


end
