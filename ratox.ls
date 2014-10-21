require! fs

dir = ''
log = null
streams = []

read-file = (filename, callback) !->
  fs.readFile dir + filename, (err, data) !->
    if err then throw err else callback data

fifo-reader = (filename) ->
  (callback) !->
    stream = fs.create-read-stream filename
    stream.on \data, callback
    streams.push stream

fifo-writer = (filename) ->
  stream = fs.create-write-stream filename
  streams.push stream
  !-> stream.write "#it\n"

#file-in = fifo-reader dir + \file_in
#file-out = fifo-writer dir + \file_out

text-in = fifo-reader dir + \text_in
text-out = fifo-writer dir + \text_out

static-data = {}

init = (callback) !->
  name <-! read-file \../name/out, _
  static-data.name-own = name
  name <-! read-file \name, _
  static-data.name-friend = name
  callback!

module.exports = {
  init: (ratox-dir, do-log, callback) !->
    dir := "#ratox-dir/"
    log := do-log
    delete module.exports.init
    callback!

  static-data
  text-in
  text-out

  # FIXME: Nothing works.
  destruct: !-> for stream in streams
    if \end in stream then stream.end!
    if \pause in stream then stream.pause!
    stream.destroy!
}
