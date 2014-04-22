require 'set'
class Comparator
	#compares two files, and prints lines of the source file that are not in the filter file
	#source - filename of source file
	#filter - filename of filter file
	attr_accessor :source, :filter

	def initialize(source_file, filter_file)
		# sets class attrs.
		@source = source_file
		@filter = filter_file
	end

	def compare_files()
		#compares the contents of two files, prints the unique lines from the first file
		filter_set = Set.new()
		File.foreach(@filter) { |line|
			filter_set.add(line)
		}
		source_array = Array.new()
		File.foreach(@source) { |line|
			source_array << line
		}
		compare(source_array, filter_set).each{ |item|
			puts "  #{item}"
		}
	end

	def compare(filtered, filter_set)
		#compares an array and a set, returns array of unique items from the first array
		unique_cnt = 0
		unique_array = Array.new()
		filtered.each { |item|
			if ! filter_set.include?(item)
				unique_array << item
				unique_cnt += 1
			end
		}
		puts "#{unique_cnt} unique lines found:"
		unique_array
	end

end

#read command line args and take appropriate action
len = ARGV.length
if len == 2
	file_one_exists = File.exists?(ARGV[0])
	file_two_exists = File.exists?(ARGV[1])
	if !file_one_exists
		puts "#{ARGV[0]} does not exist"
	end
	if !file_two_exists
		puts "#{ARGV[1]} does not exist"
	end
	if file_one_exists && file_two_exists
		comparator = Comparator.new(ARGV[0], ARGV[1])
		comparator.compare_files()
	end
else
	puts "need 2 file names, #{len} provided, try this: ruby comparator.rb file1.txt file2.txt"
end
