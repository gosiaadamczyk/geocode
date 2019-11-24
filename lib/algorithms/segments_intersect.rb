class SegmentsIntersect < BaseService
  # segment: point_1 - point_2, segment: point_3 - point_4
  def initialize(point_1, point_2, point_3, point_4)
    @point_1 = point_1
    @point_2 = point_2
    @point_3 = point_3
    @point_4 = point_4
  end

  def call
    det_1 = determinant(point_1, point_2, point_3)
    det_2 = determinant(point_1, point_2, point_4)
    det_3 = determinant(point_3, point_4, point_1)
    det_4 = determinant(point_3, point_4, point_2)

    return true if det_1 * det_2 < 0 && det_3 * det_4 < 0

    return true if det_1.zero? && on_segment(point_1, point_2, point_3)

    return true if det_2.zero? && on_segment(point_1, point_2, point_4)

    return true if det_3.zero? && on_segment(point_3, point_4, point_1)

    return true if det_4.zero? && on_segment(point_3, point_4, point_2)

    return false
  end

  private

  attr_reader :point_1, :point_2, :point_3, :point_4

  def determinant(point_1, point_2, point_3)
    point_1.x * point_2.y + point_2.x * point_3.y + point_3.x * point_1.y - point_3.x * point_2.y - point_1.x * point_3.y - point_2.x * point_1.y
  end

  def on_segment(point_1, point_2, point_3)
    point_3.x.between?(min_x(point_1, point_2), max_x(point_1, point_2)) &&
      point_3.y.between?(min_y(point_1, point_2), max_y(point_1, point_2))
  end

  def min_x(point_1, point_2)
    [point_1.x, point_2.x].min
  end

  def max_x(point_1, point_2)
    [point_1.x, point_2.x].max
  end

  def min_y(point_1, point_2)
    [point_1.y, point_2.y].min
  end

  def max_y(point_1, point_2)
    [point_1.y, point_2.y].max
  end
end
