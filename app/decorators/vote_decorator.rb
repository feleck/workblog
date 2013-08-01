class VoteDecorator < Draper::Decorator
 decorates :vote
 delegate_all

end
