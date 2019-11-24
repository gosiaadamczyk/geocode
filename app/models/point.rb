class Point
  attr_reader :x, :y

  def initialize(args)
    @x = args.fetch(:x)
    @y = args.fetch(:y)
  end
end
