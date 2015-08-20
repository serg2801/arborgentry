class HomeController < ApplicationController
  layout :resolve_layout
  def index
  end

  def login
  end

  def registration
  end

  def welcome
  end

  private
  def resolve_layout
    case action_name
    when "index"
      "application"
    when "welcome"
      "home"
    else
      "registration"
    end
  end
end
