module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    index_name [Rails.env, model_name.collection.gsub(/\//, '-')].join("_")
    
    after_save(){
      __elasticsearch__.index_document 
      true
    }
    
    after_touch() { 
      __elasticsearch__.index_document 
      true
    }

  end

  def touch
    reload
    super
  end


end