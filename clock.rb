require 'clockwork'

include Clockwork

every(2.minutes, 'Queueing interval job') { puts "Running 2 minutes.." }
