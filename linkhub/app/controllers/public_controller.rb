class PublicController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:track]

  def show
    @page = Page.friendly.find(params[:handle])

    unless @page.published?
      render file: 'public/404.html', status: :not_found, layout: false
      return
    end

    @page.increment_views!
    @links = @page.links.visible.ordered
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def track
    @page = Page.friendly.find(params[:handle])
    @link = @page.links.find(params[:link_id])

    @link.track_click!(
      ip: request.remote_ip,
      user_agent: request.user_agent,
      referrer: request.referrer
    )

    redirect_to @link.url, allow_other_host: true
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
