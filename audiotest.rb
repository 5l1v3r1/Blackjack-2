# require 'audite'
require 'gosu'

class Audio
    # player = Audite.new

    # player.events.on(:complete) do
    #   puts "COMPLETE"
    # end

    # player.events.on(:position_change) do |pos|
    #   puts "POSITION: #{pos} seconds  level #{player.level}"
    # end

    # player.load('sounds/casino-5.mp3')
    # player.start_stream
    # player.forward(20)
    # # if player.events.on(:complete)
    # #   player.toggle
    # # end
    # player.thread.join
  def initialize
    @sound = Gosu::Sample.new("sounds/casino-5.mp3")
  end
  def playSound
    @sound.play
  end

  end