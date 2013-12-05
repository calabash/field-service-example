require 'calabash-android/abase'

class Assignments < Calabash::ABase

  def trait
    "textview text:'Miguel de Icaza'"
  end


  def current_screen?
    element_exists(trait)
  end


  def tap_assignment(assignment)
    touch(assignment_query(assignment))
  end

  def tap_record_for_assignment(assignment)

    touch("#{assignment_query(assignment)} sibling * descendant ToggleButton id:'assignmentTimer'")

  end

  def assignment_query(assignment)
    "textview {text BEGINSWITH '\##{assignment[:number]}'}"
  end

  def wait_for_assignment_details
    pending
  end

  def current_timer_time
    query("TextView id:'assignmentTimerText'",:text).first
  end

end