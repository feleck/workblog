class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :vote_up_count, type: Integer, default: 0
  field :vote_down_count, type: Integer, default: 0

  belongs_to :user
  belongs_to :comment

  def value=(vote)
    #comment.abusive = true
    update_attribute :abusive, true
    if vote == "-1"
      #smth
    else
      #smth
    end
    if vote_down_count == 3
      update_attribute :abusive, false
    end
  end
end
