class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search(load: true) do
      query { string params[:query]} if params[:query].present?
      filter :range, published_at: {lte: (Time.now - 3.week) }
    end
  end
end
