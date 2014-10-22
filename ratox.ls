require! [fs, tail]

init = (dir, log, callback) !->
  dir += \/

  read-file = (filename, callback) !->
    fs.readFile dir + filename, (err, data) !->
      if err then throw err else callback data

  name <-! read-file \../name/out, _
  module.exports.name-own = "#name".trim!
  name <-! read-file \name, _
  module.exports.name-friend = "#name".trim!

  text-in = new tail.Tail dir + \text_out, '\n', { persistent: false }
  module.exports.text-in = (callback) !-> text-in.on \line, callback

  stream = fs.create-write-stream dir + \text_in
  module.exports.text-out = !-> stream.write "#it\n"

  delete module.exports.init
  callback!


module.exports = {
  init: init
}
