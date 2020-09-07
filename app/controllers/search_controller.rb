class SearchController < ApplicationController

  def search
  	@model = params["search"]["model"]
    @content = params["search"]["content"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @content)
  end

  private
  def search_for(model, content, how)
    if model == "user"
      if how == "perfect" #完全一致
        User.where(name: content)
      elsif how == "forward" #前方一致
        User.where("name LIKE ?", "#{content}%")
      elsif how == "backward" #後方一致
        User.where("name LIKE ?", "%#{content}")
      else #部分一致
        User.where("name LIKE ?", "%#{content}%")
      end
    elsif model == "book"
      if how == "perfect"
        Book.where(title: content)
      elsif how == "forward"
        Book.where("title LIKE ?", "#{content}%")
      elsif how == "backward"
        Book.where("title LIKE ?", "%#{content}")
      else
        Book.where("title LIKE ?", "%#{content}%")
      end
    end
  end
end
