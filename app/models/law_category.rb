class LawCategory < ActiveRecord::Base
  has_many :laws
  attr_accessible :subtitle, :title    
end
