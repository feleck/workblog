class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :comment

  def value1=(vote)
    vote += vote
    if vote == 3
      comment.abusive = true
    end
  end
end
