class Foo # name must be capitalized
	@bar = 2
	attr_accessor :x

	def initialize(x)
		@x = x
	end

	def m1
		puts @bar
	end

	def m2 (x,y)
	end

	def self.hello # class methods, like statics in C#
		puts "from class method"
	end

	def celsius_temp= x
		@kelvin_temp = x + 273.15
	end
end

myfoo = Foo.new("value of x")
myfoo.m1

puts Math::PI # class constant
puts Foo.hello
puts myfoo.x

puts myfoo.class.superclass # let's us know the superclass of Foo