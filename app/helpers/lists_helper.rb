module ListsHelper

    def caret dir

        "<i class='icon-chevron-#{ dir == 'asc' ? 'down' : 'up' }'></i>"

    end

    def sort_column col, title = nil

        title ||= col.split("_").map(&:capitalize).join(" ")

        head = "<span class='sort-column' data-column='#{col}'>"

        head << title

        head << " " << caret( params[:dir] ) if params[:sortBy] == col

        head << "</span>"

        head.html_safe
    end

end
