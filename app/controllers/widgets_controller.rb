class WidgetsController < ApplicationController
  layout false
  def comments
    headers["Content-Type"] = "text/javascript; charset=utf-8"
  end

  def form
    headers["Content-Type"] = "text/javascript; charset=utf-8"
  end

  def comments_and_form
    headers["Content-Type"] = "text/javascript; charset=utf-8"
  end

  def count
    headers["Content-Type"] = "text/javascript; charset=utf-8"
  end
end
