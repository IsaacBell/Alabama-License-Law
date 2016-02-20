module LawsHelper
	def get_max
		@max = Law.last.id
		return @max
	end
end
