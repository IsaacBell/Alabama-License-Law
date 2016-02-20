class Bookmark < ActiveRecord::Base
  belongs_to :law
  belongs_to :user
  attr_accessible :law_id, :user_id
end
