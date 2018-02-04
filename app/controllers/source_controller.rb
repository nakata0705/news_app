class SourceController < ApplicationController
  def view
    @items = Source.all
  end
end
