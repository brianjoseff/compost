class PagesController < ApplicationController
  skip_before_filter :admin_user
  def about
  end
end