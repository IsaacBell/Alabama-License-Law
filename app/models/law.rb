class Law < ActiveRecord::Base
  has_many :bookmarks
  belongs_to :law_category
  attr_accessible :id, :legal_id, :title, :content, :position, :law_category_id

  # finds and returns the next law in the list
  def getNextLaw
    Law.find(:last, :conditions => ["position > ?", self.position], :order =>"position DESC")
  end

  # finds and returns the previous law in the list
  def getPrevLaw
    Law.find(:first, :conditions => ["position < ?", self.position], :order => "position DESC")
  end

end
