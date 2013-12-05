
module FieldService
  module AndroidHelpers

    def enter_text(uiquery, text, options={})
      query(uiquery, {:setText => text})
    end

  end
end
