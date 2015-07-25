class PostsDatatable
  delegate :params, :link_to, :post_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Post.count,
      iTotalDisplayRecords: total_count,
      aaData: get_data
    }
  end

private
  def was_select_sorting_column?
    params[:iSortingCols].to_i > 0
  end
  
  def has_search_query?
    params[:sSearch].present?
  end

  def get_data
    begin
      data
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest
      Rails.logger.error("########  BadRequest of Elasticsearch when try to call method data ########")
      []
    end
  end

  def data
    index = (page - 1) * per_page 

    fetch_records.map do |post|
      [
        index += 1,
        link_to(post.title, post_path(post.id)),
        post.category[:title],
        post.content,
        post.tag_list,
        post.created_at.try(:to_date).to_s
      ]
    end
  end

  def available_columns
    [nil, :"title.sort", :"category.title.sort", nil, nil, :"created_at"]
  end

  def total_count
    begin
      fetch_records.total 
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest
      Rails.logger.error("########  BadRequest of Elasticsearch when try to call method total ########")
      0
    end
  end

  def fetch_records
    return @fetch_records if @fetch_records
    options  = {} 
    options[:sort]   = { sort_column => sort_direction }
    options[:paging] = { from: from_record, size: per_page }
    query_params = {q: params[:sSearch], tag_list: get_tag_list}
    searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new query_params, options
    @fetch_records = searcher.get_records
    @fetch_records = @fetch_records.results
    @fetch_records
  end

  def sort_column
    return available_columns[params[:iSortCol_0].to_i] if was_select_sorting_column?
    return "_score" if has_search_query?
    "created_at"
  end

  def get_tag_list
    params[:tag_list].split(",")
  end

  def sort_direction
    return "desc" unless was_select_sorting_column?
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def from_record
    (page - 1) * per_page
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

end