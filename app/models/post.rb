class Post < ActiveRecord::Base
  include Searchable

  scope :published,   -> {where(published: true)}
  scope :unpublished, -> {where(published: true)}

  acts_as_taggable
  
  belongs_to :category
  has_many   :comments

  validates :title, presence: true
  validates :category, presence: true, :if => :published?


  settings analysis: {
    tokenizer: {
      ngram_tokenizer: {
        type: "nGram",
        min_gram: "1",
        max_gram: "15",
        token_chars: [ "letter", "digit" ]
      }
    },
    analyzer: {
      default: {
        type: "custom",
        tokenizer: "ngram_tokenizer",
        filter: ["lowercase"]
      },
      sortable: {
        tokenizer: 'keyword',
        filter: ["lowercase"]
      }
    }
  } do
    mapping do
      indexes :title, type: 'multi_field' do
        indexes :title, boost: 10
        indexes :sort, analyzer: 'sortable'
      end      

      indexes :created_at, type: 'date'
      indexes :content, type: 'string'

      indexes :category, type: 'nested' do
        indexes :title, type: 'multi_field' do
          indexes :title
          indexes :sort, analyzer: 'sortable'
        end
        indexes :id, type: 'long'
      end
    end
  end

  def as_indexed_json(options={}) #for elasticsearch
    self.as_json(
        include: {
          category: { only: [:id, :title]},
        }
      ).merge! tag_list: tag_list
  end



  def publish!
    self.published = true and save
  end

  def unpublish!
    self.published = false
    save
  end
end
