require 'time'
require 'shellwords'

def autoCommit(startTime, commitsPerDay, path)
	cmd = "ls " + path
	value = `#{cmd}`
	files = value.split("\n")
	pendingFolders = []
	# for file in files
	# 	puts "is directory" if File.directory?(path + file)
	# 	puts "is file" if File.file?(path + file)
	# end

	total = files.length;
	tempTime = startTime

	(1..total).each do |i|
		if File.directory?(path + files[i-1])
			pendingFolders << files[i-1]
		else
			cmd = "git add " + path + Shellwords.escape(files[i-1])
			value = `#{cmd}`

			if(i % commitsPerDay == 0)
				startTime += 60*60*24
				tempTime = startTime
			else
				tempTime += 60*60
			end

			cmd = "git commit -m " + "'Added #{files[i-1]}'"
			value = `#{cmd}`
			cmd = "git commit --amend --date='" + tempTime.to_s +  "' --no-edit"
			value = `#{cmd}`
			puts value
		end
	end

	for folder in pendingFolders
		startTime += 60*60*24
		startTime = autoCommit(startTime, commitsPerDay, path +folder+ '/')
	end
	return startTime
end

def test
	(0..5).each do |i|
		temp = time
		(0..3).each do |j|
			puts temp
			temp += 60*60
		end
		time += 60*60*24
	end
end

# time = Time.parse("Sat Jul 15 18:00:00 IST 2015")
autoCommit(Time.parse(ARGV[1]), 6, ARGV[0])
