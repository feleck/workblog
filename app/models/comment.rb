class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false

  belongs_to :post
  belongs_to :user
  has_many :votes
end
