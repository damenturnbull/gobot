# gobot - Toy Robot Simulator
A small, test driven Ruby application that simulates a robot moving on a tabletop.

Setup
-----------
- Gobot makes use of the require_all gem to ease "PATH pain" during testing.

To run tests:
### 
    $ bundle install
    $ rspec

Assumptions
-----------
- Gobot has geolocation awareness ie. Gobot is responsible for knowing what it's x and y coordinates are in relation to the tabletop.

Specification
-----------
See PROBLEM.md