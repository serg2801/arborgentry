class HomeController < ApplicationController
  layout :resolve_layout
  def index
  end

  def login
  end

  def registration
  end

  private
  def resolve_layout
    case action_name
    when "index"
      "application"
    else
      "registration"
    end
  end
end
