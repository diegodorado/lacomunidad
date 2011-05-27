class WikiPagesController < ApplicationController

  acts_as_wiki_pages_controller

  def show_allowed?
    true
  end
  def history_allowed?
   false
  end
  def edit_allowed?
    true
  end

end
