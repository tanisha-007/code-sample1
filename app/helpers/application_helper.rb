# frozen_string_literal: true

module ApplicationHelper
  def body_classes
    [controller_name, action_name].join(" ")
  end
end
