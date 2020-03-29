class MainPageController < ApplicationController
  def index
    @collections = Collection.all
  end
end
