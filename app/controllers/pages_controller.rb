require 'net/http'
require 'uri'
require 'nokogiri'

class PagesController < ApplicationController

  def index
    @pages = Page.all
    @pages_count = @pages.count
    @pages = @pages.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  def create

    content = get_content( page_params['url'])
    # rescue
    #   render json: { errors: 'invalid page' }, status: :unprocessable_entity
    #   return
    # end

    body = {
      :url => page_params['url'],
      :content => content
    }

    begin
      @page = Page.new(body)
    end

    if @page.save
      render :show
    else
      render json: { errors: @page.errors }, status: :unprocessable_entity
    end
    rescue Exception => e
      render json: { errors: e.message }, status: :unprocessable_entity
  end

  def show
    @page = Page.find_by_url!(params[:url])
  end

  private

  def get_content(url)
    if url[0..3] != 'http'
      url = 'http://' + url
    end
    fullpage = open(url)
    raw = Nokogiri::HTML(fullpage).css('h1,h2,h3,a')
    content = ""
    raw.map { |c|
      content += " \n" + c
    }
    content
  end

  def page_params
    params.require(:page).permit(:url)
  end

  def open(url)
    Net::HTTP.get(URI.parse(url))
  end
end