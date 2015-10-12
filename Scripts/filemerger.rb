
def merge(filename, rest, mergedFile)
	contents = File.open(filename);
	flag = true;

	contents.lines do |line|
		if line.start_with?("import")
			mergedFile.puts line
		else
			if(flag && line.start_with?("public"))
				line.sub!("public ", "")
				flag = false
			end
			rest += line
		end
	end

	rest
end

def start
	path = "/Users/shubham/Documents/workspace/"
	srcfolder = "Hackerearth/src/SegmentTree/"
	files = gets.chomp.split(" ")
	rest = ""
	mergedFile = File.open("output.java", 'w');

	files.each do |file|
		rest = merge(File.join(path, srcfolder, file), rest, mergedFile)
	end

	mergedFile.close
	File.open('output.java', 'a') do |f|
		f.puts rest
	end
end


start