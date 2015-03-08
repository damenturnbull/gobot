require_relative '../lib/gobot'
require_relative '../lib/tablegrid'

puts <<-eos
------------------
Welcome to Gobot.
------------------
Input commands are listed below:
  PLACE  - places the toy robot in a specified location on the table top.
           eg. PLACE 0,0,NORTH
           eg. PLACE 4,4,SOUTH
  MOVE   - moves the toy robot one unit forward.
  LEFT   - turns the Robot left.
  RIGHT  - turns the Robot right.
  REPORT - outputs current position on the table top.
------------------
eos

gobot = Gobot.new(TableGrid.new(5,5))
gobot.start