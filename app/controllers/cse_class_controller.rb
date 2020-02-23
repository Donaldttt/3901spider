class CseClassController < ApplicationController

  def index
    @classes=CseClass.all
  end

  def create
    @record=CseClass.new(c_params)
    @record.save
    render :edit_page
  end

  def delete_all
    CseClass.delete_all
    redirect_to 'http://localhost:3000'
  end

  def edit_page
    @record=CseClass.new
  end

  def c_params
    params.permit(:name,:section,:room,:instructor)
  end

  def scrape
    CseClass.delete_all
    Spider::CSESpider.process
    redirect_to 'http://localhost:3000'
  end
end
