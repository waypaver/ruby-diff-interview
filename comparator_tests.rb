require "comparator"
require "test/unit"

class TestComparator < Test::Unit::TestCase
	def test_compare()
		comp = Comparator.new("foo.txt", "bar.txt")
		source = ['a', 'b', 'c', 'd']
		filter = ['z', 'y', 'x', 'd']
		expected = ['a', 'b', 'c']
		result = comp.compare(source, filter)
		assert_equal(expected, result)
	end
end