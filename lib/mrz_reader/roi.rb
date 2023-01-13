module MrzReader
  class Roi
    attr_reader :pixels, :x1, :y1, :x2, :y2

    def initialize pixels
      @pixels = pixels
      find_rect
    end

    def surface
      @pixels.count
    end

    def find_rect
      xx = @pixels.minmax{|p1, p2| p1[0] <=> p2[0]}
      xx = @pixels.map{|x ,y| x}
      @x1, @x2 = xx.minmax
      yy = @pixels.map{|x ,y| y}
      @y1, @y2 = yy.minmax
    end

    def width
      @x2 - @x1
    end

    def height
      @y2 - @y1
    end

    def aspect_ratio
      width.to_f / height.to_f
    end

    def crop_height
      crop_y2 - crop_y1
    end

    def crop_width
      crop_x2 - crop_x1
    end

    def crop_x1
      @x1 - 10
    end

    def crop_x2
      @x2 + 10
    end

    def crop_y1
      @y1 - 10
    end

    def crop_y2
      @y2 + 10
    end

    def merge roi
      @pixels = @pixels + roi.pixels
      Roi.new(@pixels)
    end
  end
end
