class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  after_create :mark_abusive

  field :value, type: Integer, default: 0

  belongs_to :user
  belongs_to :comment


  protected 
  def mark_abusive
    votes = comment.votes
    votes_down = 0

    if !votes.empty?
      votes.each do |vote|
        if vote.value == -1
           votes_down += 1
        end
        if votes_down >= 3
          comment.update_attribute(:abusive, true)
        end
      end
    end
    
  end

end
