class Days < Duration
	def initialize number = 1
		super(:days => number)
	end
end

class Day < Days
	def initialize
		super(1)
	end
end

