require! fs

dir = ''
log = null

read-file = (filename, callback) !->
  fs.readFile dir + filename, (err, data) !->
    if err then throw err else callback data

fifo-reader = (filename) ->
  (callback) !->
    stream = fs.create-read-stream filename
    stream.on \data, callback

fifo-writer = (filename) ->
  stream = fs.create-write-stream filename
  !-> stream.write "#it\n"


init = (ratox-dir, do-log, callback) !->
  dir := "#ratox-dir/"
  log := do-log
  name <-! read-file \../name/out, _
  module.exports.name-own = "#name".trim!
  name <-! read-file \name, _
  module.exports.name-friend = "#name".trim!

  #file-in = fifo-reader dir + \file_in
  #file-out = fifo-writer dir + \file_out

  module.exports.text-in = fifo-reader dir + \text_out
  module.exports.text-out = fifo-writer dir + \text_in

  delete module.exports.init
  callback!


module.exports = {
  init: init
}
