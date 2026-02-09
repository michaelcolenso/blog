class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page
  before_action :set_link, only: [:update, :destroy]

  def create
    @link = @page.links.build(link_params)

    if @link.save
      redirect_to edit_page_path, notice: 'Link added successfully!'
    else
      redirect_to edit_page_path, alert: 'Failed to add link.'
    end
  end

  def update
    if @link.update(link_params)
      redirect_to edit_page_path, notice: 'Link updated successfully!'
    else
      redirect_to edit_page_path, alert: 'Failed to update link.'
    end
  end

  def destroy
    @link.destroy
    redirect_to edit_page_path, notice: 'Link deleted successfully!'
  end

  private

  def set_page
    @page = current_user.page
  end

  def set_link
    @link = @page.links.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :url, :icon, :visible, :position)
  end
end
