require! [blessed, fs]

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

screen.append log
screen.append line
screen.append textbox

screen.key [\q, \C-c], -> process.exit 0

screen.key \i, !-> textbox.read-input ->

screen.key \e, !-> textbox.read-editor ->

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
  do-log it
  textbox.clear-value!
  textbox.read-input ->
  screen.render!

textbox.read-input ->

fs.readFile \init.txt, (err, data) !->
  #if err then throw err
  if err then return
  log.push-line "#data"
  log.set-scroll-perc 100pc
  screen.render!

screen.render!
