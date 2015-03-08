# Fake standard input by intercepting STDIN
class FakeStdin
  attr_reader :inputs

  def initialize
    @inputs = []
  end

  def read(input)
    @inputs << input
  end

  def gets
    @inputs.shift
  end
end