class Minutes < Duration
	def initialize number = 1
		super(:minutes => number)
	end
end

class Minute < Minutes
	def initialize
		super(1)
	end
end

