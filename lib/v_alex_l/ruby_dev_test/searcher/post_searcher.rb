class VAlexL::RubyDevTest::Searcher::PostSearcher
  class << self
    def get_query(query_params)
      @get_query =  { filtered: {
                        query: {}
                      }
                  }
      @get_query[:filtered][:query]  = get_query_block(query_params[:q])
      @get_query[:filtered][:filter] = get_filter_block(query_params[:tag_list]) 
      
      @get_query
    end

    def get_sort(sort)
      return {} if sort.blank?
      field     = sort.keys.first
      direction = sort.values.first
      { field => { order: direction, missing: :_last }}
    end

    def get_paging(paging)
      return { from: 0, size: 10 } if paging.blank?
      paging.slice(:from, :size)
    end

    private
      def get_query_block(query)
        query = query.to_s.strip
        query = query.gsub(/\s+/, " ")
        query = query.gsub(/-/, " ")
        if query.length.zero?
          {:match_all => {}}
        else
          { :multi_match => {
                            query:  query,
                            operator: 'AND',
                            fields: ["_all"]
                          }
          }
        end
      end

      def get_filter_block(tag_list)
        return {} if tag_list.blank?
        and_block = tag_list.inject([]) do |res, tag|
          res.push({ term: {tag_list: tag}})
        end
        {:and => and_block}
      end

  end

  def initialize(query_params, options={})
    @search_settings =  {   
                           query:  VAlexL::RubyDevTest::Searcher::PostSearcher.get_query(query_params),
                           sort:   VAlexL::RubyDevTest::Searcher::PostSearcher.get_sort(options[:sort]),
                           highlight: {
                                   pre_tags: ['<em class="label label-highlight">'],
                                   post_tags: ['</em>'],

                                   fields: { "*" => { number_of_fragments: 0 } },
                            }
                        }
                        
    @search_settings.merge! VAlexL::RubyDevTest::Searcher::PostSearcher.get_paging(options[:paging])
  end

  def get_records
    # search_settings = {default_operator: 'AND', size: klass.count}
    # search_settings.merge! sort: { by sort_column, @sort_direction}} if was_given_sort_column?
    records = ::Post.__elasticsearch__.search(@search_settings, preference: '_primary').records
    records
  end

end
