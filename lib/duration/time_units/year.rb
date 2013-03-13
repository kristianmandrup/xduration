class Years < Duration
	def initialize number = 1
		super(:years => number)
	end
end

class Year < Years
	def initialize
		super(1)
	end
end
