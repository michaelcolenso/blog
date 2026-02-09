class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = current_user.page
    @links = @page.links.ordered
    @subscription = current_user.subscription

    # Analytics summary (last 30 days)
    @total_views = @page.views_count || 0
    @total_clicks = @page.clicks.where('clicked_at > ?', 30.days.ago).count
    @recent_clicks = @page.clicks.order(clicked_at: :desc).limit(10)
  end
end
