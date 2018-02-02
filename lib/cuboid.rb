class Cuboid
  attr_accessor :origin, :dimensions

  def initialize(origin: { x: 0, y: 0, z: 0 }, dimensions: { w: 0, h: 0, l: 0 })
    @origin = origin
    @dimensions = dimensions

    # Must be a cuboid
    raise "Cuboid must have dimensions" if is_point?

    # Check for invalid params
    any_invalid_point_value?(origin)
    any_invalid_point_value?(dimensions)

    # Generate min/max
    @origin.each do |axis, point|
      define_singleton_method("#{axis}_min") { point }
      define_singleton_method("#{axis}_max") { point + dimension_from_axis(axis) }
    end
  end

  # Probably a meta way to do this but it works for
  # the cuboid case
  def vertices
    [
      @origin,
      { x: x_max, y: y_min, z: z_min },
      { x: x_min, y: y_max, z: z_min },
      { x: x_min, y: y_min, z: z_max },
      { x: x_max, y: y_max, z: z_min },
      { x: x_max, y: y_min, z: z_max },
      { x: x_min, y: y_max, z: z_max },
      { x: x_max, y: y_max, z: z_max }
    ]
  end

  def move_to!(x, y, z)
    new_origin = { x: x, y: y, z: z }
    any_invalid_point_value?(new_origin)
    @origin = new_origin
  end

  # Returns true if the two cuboids intersect each other. False otherwise.
  # Use simple AABB algorithm
  def intersects?(other)
    @origin.keys.each do |axis|
      return false unless min_lte_max(axis, other) && max_gte_min(axis, other)
    end
    true
  end

  def is_point?
    (dimensions.values.inject(:+) || 0) == 0
  end

  private

  def min_lte_max(axis, other)
    send("#{axis}_min") <= other.send("#{axis}_max")
  end

  def max_gte_min(axis, other)
    send("#{axis}_max") >= other.send("#{axis}_min")
  end

  # Map x,y,z -> l,w,h
  def origin_dimension_key_map
    @origin_dimension_map ||= begin
      origin_keys = @origin.keys.to_a
      dimension_keys = @dimensions.keys.to_a
      raise "origin and dimensions are not of same length" if origin_keys.size != dimension_keys.size
      Hash[[origin_keys, dimension_keys].transpose]
    end
  end

  def dimension_from_axis(axis)
    @dimensions[origin_dimension_key_map[axis]]
  end

  def any_invalid_point_value?(points)
    points.each do |axis, value|
      raise(StopIteration, "#{axis} must be >= 0. #{value} was passed.") unless value >= 0
    end
  end
end
