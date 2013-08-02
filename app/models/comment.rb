class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false

  validates_presence_of :body

  belongs_to :post
  #embedded_in :post, :inverse_of => :comments
  belongs_to :user
  has_many :votes

end
