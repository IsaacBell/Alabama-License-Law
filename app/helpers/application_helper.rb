module ApplicationHelper
	def get_categories
		@categories = LawCategory.all
	end

	#def get_saves(userid)
	#	@saves = Savedlaw.where(:userid => userid).order("law_id")
	#end

	def get_law(law_id)
		@law2 = Law.find(law_id)
	end
end
