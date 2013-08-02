class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  after_create :mark_abusive

  #field :vote_up_count, type: Integer, default: 0
  #field :vote_down_count, type: Integer, default: 0
  field :value, type: Integer, default: 0

  belongs_to :user
  belongs_to :comment

  protected 
  def mark_abusive
    comment_id = self.comment_id
    #post = Post.find(params[:post_id])
    comment = Comment.find(comment_id)
    votes = comment.votes
    votes_down = 0
    puts 'echco'
    if !votes.empty?
      votes.each do |vote|
        if vote.value == -1
          votes_down += 1
        end
        if votes_down >= 3
          comment.update_attributes(abusive: true)
          #comment.abusive = true
          comment.save

        end
      end
    end
  end
end
