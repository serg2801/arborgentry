class HomeController < ApplicationController
  layout :resolve_layout
  before_filter :authenticate_vendor! , :except => [:welcome]
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
