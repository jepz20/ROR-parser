require 'net/http'
require 'uri'
require 'nokogiri'

class PagesController < ApplicationController

  def index
    @pages = Page.all.includes(:contents)
    @pages_count = @pages.count
    @pages = @pages.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  def create
    url = page_params['url']

    body = {url: url}

    @page = Page.new(body)
    save_content(url)

    if @page.save
      render :show
    else
      render json: { errors: @page.errors }, status: :unprocessable_entity
    end

    rescue Exception => e
      puts e.message
      render json: { errors: 'unexpected error' }, status: :unprocessable_entity
  end

  private

  def save_content(url)
    if url[0..3] != 'http'
      url = 'http://' + url
    end

    fullpage = open(url)
    raw = Nokogiri::HTML(fullpage).css('h1, h2, h3, a')
    raw.map { |node|
      body = {
        text: node.text,
        tag: node.name
      }

      if node.name === 'a'
        body['href'] = node["href"]
      end

      content = Content.new(body)
      @page.contents << content
    }
  end

  def page_params
    params.require(:page).permit(:url)
  end

  def open(url)
    Net::HTTP.get(URI.parse(url))
  end
end