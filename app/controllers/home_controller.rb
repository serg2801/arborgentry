class HomeController < ApplicationController
  layout :resolve_layout
  before_filter :authenticate_vendor! , :except => [:welcome, :thank_you]
  def index
  end

  def login
  end

  def registration
  end

  def welcome
  end

  def thank_you
  end

  private
  def resolve_layout
    case action_name
    when "index"
      "application"
    when "welcome"
      "home"
    when "thank_you"
      "home"
    else
      "registration"
    end
  end
end
