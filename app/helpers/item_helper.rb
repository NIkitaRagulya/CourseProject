module ItemHelper

    def tag_cloud(tags)
        max = tags.sort_by(&:count).last
        tags.each do |tag|
            yield(tag)
        end
    end

    def nil_author
        Collection.find(params[:collection_id]).author.nil?
    end

    def nil_brand
        Collection.find(params[:collection_id]).brand.nil?
    end

    def nil_year_of_publishing
        Collection.find(params[:collection_id]).year_of_publishing.nil?
    end

end
