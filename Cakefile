fs = require 'fs'
{exec} = require 'child_process'

stripSlash = (name) ->
	name.replace /\/\s*$/, ''

watch = (dir, ext, fn) ->
	stampName = ".stamp_#{stripSlash(dir)+ext}"

	watchFiles = (err, stdout, stderr) ->
		return error("watch(#{dir})", stderr) if err?
		for file in stdout.split /\s+/
			continue unless file.match ext
			fs.watch file, ((file) -> (event) -> fn(event, file))(file)
		exec "touch #{stampName}"
	
	fs.watch dir, -> exec "find #{stripSlash(dir)} -newer #{stampName}", watchFiles
	exec "find #{stripSlash(dir)}", watchFiles

task 'build', ->
	exec 'coffee --output js/ --compile coffee/', (err, stdout, stderr) ->

task 'watch', ->
	watch 'coffee/', '.coffee', (event, filename) ->
		invoke 'build'		
