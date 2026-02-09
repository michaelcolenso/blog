class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page

  def show
    @links = @page.links.ordered
  end

  def edit
    @links = @page.links.ordered
  end

  def update
    if @page.update(page_params)
      redirect_to page_path, notice: 'Page updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_page
    @page = current_user.page
  end

  def page_params
    params.require(:page).permit(:handle, :title, :description, :theme, :avatar_url, :published)
  end
end
