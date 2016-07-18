class StaticPageController < ApplicationController
  alias_method :current_user, :current_vendor
  skip_before_filter :authenticate_vendor!

  layout "vendor_form", only: [:form_home, :form_home, :trade_update, :about, :product_categories]

  #vendor_form
  def form_home
  end

  def form_home
  end

  def vendor
  end

  # def board
  # end
  #
  # def board_update
  # end

  def trade_update
  end

  def about
  end

  def product_categories
  end

  #Charts
  def other_charts
  end

  def chart_js
  end

  def morris_charts
  end

  def flot_charts
  end

  #Forms
  def basic_forms
  end

  def advanced_forms
  end

  def form_layouts
  end

  def form_wizard
  end

  def form_validation
  end

  def code_editor
  end

  #Tables
  def basic_tables
  end

  def data_tables
  end

  def editable_tables
  end

  def ajax_tables
  end

  def pricing_tables
  end


  def icons
  end

  def typography
  end

  def tabs
  end

  def accordions
  end

  def buttons
  end

  def notifications
  end

  def modals
  end

  def sliders
  end

  def progressbar
  end

  def lists
  end

  def grid
  end

  def other
  end

  def portlets
  end

  #Maps
  def google_maps
  end

  def vector_maps
  end

  #Pages

  def login
  end

  def lock_screen
  end

  def register
  end

  def lost_password
  end

  def user_profile
  end

  def calendar
  end

  def time_line
  end

  def gallery
  end

  def invoice
  end

  def blank_page
  end
end
