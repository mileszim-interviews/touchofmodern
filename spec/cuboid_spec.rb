require 'cuboid'

describe Cuboid do
  describe "#initialize" do
    it "sets origin to 0,0,0 if none given" do
      cuboid = Cuboid.new(dimensions: { w: 1, h: 1, l: 1 })
      expect(cuboid.origin).to eql({ x: 0, y: 0, z: 0 })
    end

    it "raises an error if any dimension is <= 0" do
      expect { cuboid = Cuboid.new() }.to raise_error
    end

    it "generates min and max methods for each axis" do
      cuboid = Cuboid.new(dimensions: { w: 1, h: 1, l: 1 })
      expect(cuboid.x_min).to eq(0)
      expect(cuboid.x_max).to eq(1)
      expect(cuboid.y_min).to eq(0)
      expect(cuboid.y_max).to eq(1)
      expect(cuboid.z_min).to eq(0)
      expect(cuboid.z_max).to eq(1)
    end

    it "returns a generated cuboid with good parameters" do
      expect {
        cuboid = Cuboid.new(dimensions: { w: 1, h: 1, l: 1 }, origin: { x: 1, y: 1, z: 1 })
      }.to_not raise_error
    end
  end

  describe "#vertices" do
    it "gives a list of vertices" do
      vertices = [
        { x: 0, y: 0, z: 0 },
        { x: 2, y: 0, z: 0 },
        { x: 0, y: 3, z: 0 },
        { x: 0, y: 0, z: 4 },
        { x: 2, y: 3, z: 0 },
        { x: 2, y: 0, z: 4 },
        { x: 0, y: 3, z: 4 },
        { x: 2, y: 3, z: 4 }
      ]
      cuboid = Cuboid.new(dimensions: { w: 2, h: 3, l: 4 })
      expect(cuboid.vertices).to eql(vertices)
    end
  end

  describe "#move_to!" do
    it "raises an error if x, y, z invalid" do
      cuboid = Cuboid.new(dimensions: { w: 2, h: 3, l: 4 })

      expect {
        cuboid.move_to!({ x: -1, y: 0, z: 0 })
      }.to raise_error
      expect {
        cuboid.move_to!({ x: 0, y: -1, z: 0 })
      }.to raise_error
      expect {
        cuboid.move_to!({ x: 0, y: 0, z: -1 })
      }.to raise_error
    end

    it "moves the object" do
      cuboid = Cuboid.new(dimensions: { w: 2, h: 3, l: 4 })

      expect {
        cuboid.move_to!(1, 1, 1)
      }.to_not raise_error

      expect(cuboid.origin).to eql({ x: 1, y: 1, z: 1 })
    end
  end

  describe "#intersects?" do
    it "returns true if intersecting with another cuboid" do
      cuboid1 = Cuboid.new(dimensions: { w: 3, h: 3, l: 3 })
      cuboid2 = Cuboid.new(dimensions: { w: 1, h: 1, l: 1 }, origin: { x: 1, y: 1, z: 1 })

      expect(cuboid1.intersects?(cuboid2)).to eq(true)
      expect(cuboid2.intersects?(cuboid1)).to eq(true)
    end

    it "returns false if not intersecting with another cuboid" do
      cuboid1 = Cuboid.new(dimensions: { w: 1, h: 1, l: 1 })
      cuboid2 = Cuboid.new(dimensions: { w: 1, h: 1, l: 1 }, origin: { x: 4, y: 0, z: 0 })
      
      expect(cuboid1.intersects?(cuboid2)).to eq(false)
      expect(cuboid2.intersects?(cuboid1)).to eq(false)
    end
  end

  describe "#is_point?" do
    it "returns true if cuboid has no dimensions" do
      cuboid = Cuboid.new(dimensions: { w: 1, h: 1, l: 1 })
      allow(cuboid).to receive(:dimensions) { { w: 0, h: 0, l: 0 } }
      expect(cuboid.is_point?).to eq(true)
    end

    it "returns false if cuboid has dimensions" do
      cuboid = Cuboid.new(dimensions: { w: 1, h: 1, l: 1 })
      expect(cuboid.is_point?).to eq(false)
    end
  end
end
