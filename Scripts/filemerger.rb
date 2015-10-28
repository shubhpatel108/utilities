@headers = []
@flag = true

def merge(filename)
	contents = File.open(filename);

	rest = ""

	contents.lines do |line|
		if line.start_with?("package")
			next
		end

		if line.start_with?("import")
			@headers << line
		else
			if(@flag && line.start_with?("public class"))
				line.sub!("public ", "")
				@flag = false
			end
			rest += line
		end
	end

	rest
end

def start
	path = "/Users/shubham/Documents/workspace/"
	srcfolder = "Hackerearth/src/graph/"
	files = gets.chomp.split(" ")

	mergedcontent = ""

	files.each do |file|
		mergedcontent += merge(File.join(path, srcfolder, file))
	end

	@headers.uniq!

	mergedFile = File.open("output.java", 'w');
	mergedFile.puts @headers
	mergedFile.puts mergedcontent
	mergedFile.close
end


start