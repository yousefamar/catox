require! [fs, blessed, \./ratox.js]

screen = blessed.screen!

log = blessed.box {
  parent: screen
  scrollable: true
  always-scroll: true
  vi: true
  top: 0char
  bottom: 2chars
}

line = blessed.line {
  parent: screen
  orientation: \horizontal
  bottom: 1char
}

textbox = blessed.textbox {
  parent: screen
  keys: false
  height: 1char
  bottom: 0chars
  style:
    fg: \white
}

do-log = !->
  log.push-line it
  log.set-scroll-perc 100pc
  screen.render!

screen.append log
screen.append line
screen.append textbox

screen.key [\q, \C-c], !->
  ratox.destruct!
  process.exit!
  #process.kill process.pid, \SIGINT

screen.key \j, !->
  log.scroll 10chars
  screen.render!
screen.key \k, !->
  log.scroll -10chars
  screen.render!
screen.key \S-j, !->
  log.scroll 1char
  screen.render!
screen.key \S-k, !->
  log.scroll -1char
  screen.render!

textbox.on \submit, !->
  textbox.clear-value!
  textbox.read-input ->
  do-log it
  ratox.text-out it

init = !->
  ratox.text-in !-> do-log "#it".trim!
  screen.key \i, !-> textbox.read-input ->
  screen.key \e, !-> textbox.read-editor ->
  textbox.read-input ->

fs.readFile __dirname + \/init.txt, (err, data) !->
  #if err then throw err
  if not err then do-log "#data"
  ratox-dir = process.cwd!
  if process.argv.length > 2 then ratox-dir = process.argv[2]
  ratox.init ratox-dir, do-log, init

screen.render!
