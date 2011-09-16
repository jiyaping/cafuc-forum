class SearchController < ApplicationController
    def search
        @page_title ="search"
        if params[:commit]="Search"||params[:q]
            @posts= Post.find_by_contents(params[:q].to_s.upcase)
            unless @post.size>0
                flash[:notice]="没有符合的结果"
    end
end
