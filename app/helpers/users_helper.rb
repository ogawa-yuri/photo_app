module UsersHelper
  def button_text
    if action_name == "new"
      "Create my account"
    elsif action_name == "edit"
      "Update my account"
    end
  end
end
