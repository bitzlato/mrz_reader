module MrzReader
  class RoiManager
    MIN_SURFACE = 1000
    MIN_ASPECT_RATIO = 4
    MAX_ASPECT_RATIO = 80
    MIN_ROI_TO_IMAGE_WIDTH_RATIO = 0.6
    MIN_WIDTH_RATE_FROM_MAX_WIDTH_ROI = 0.8

    attr_reader :image, :rois

    def initialize image
      @image = image
      @rois = []
    end

    def compute
      build_pixel_matrix
      rois = find_rois

      rois = rois.find_all{|r| r.surface > MIN_SURFACE }
      rois = rois.find_all{|r| r.width.to_f / image.width > MIN_ROI_TO_IMAGE_WIDTH_RATIO }
      rois = rois.find_all{|r| r.aspect_ratio > MIN_ASPECT_RATIO && r.aspect_ratio < MAX_ASPECT_RATIO}
      max_width_roi = rois.sort{|r| r.width }.last
      rois = rois.find_all{|r| r.width.to_f / max_width_roi.width > MIN_WIDTH_RATE_FROM_MAX_WIDTH_ROI }
      # save_image_rois(rois)
      if rois.any?
        roi = Roi.new([])
        rois.each{|r| roi = roi.merge(r)}
        roi
      end
    end

    private

    def save_image_rois rois
      rois.each_with_index do |roi, index|
        @image.combine_options do |b|
          b.fill('none')
          b.stroke('blue')
          b.strokewidth(3)
          b.draw("rectangle #{roi.x1},#{roi.y1} #{roi.x2},#{roi.y2}")
        end
      end
      @image.write "./tmp/rois.png"
    end

    def build_pixel_matrix
      result = {}
      pixels = image.get_pixels

      pixels.each_with_index do |y, y_index|
        y.each_with_index do |x, x_index|
          if x != [0, 0, 0]
            result[x_index] = [] unless result[x_index]
            result[x_index] << y_index
          end
        end
      end

      @matrix = result
    end

    def find_rois
      @roi = []
      start_pixel = get_start_pixel

      while start_pixel != nil
        pixels_to_scan = [start_pixel]
        while pixels_to_scan != []
          pixels_to_scan = get_pixels_to_scan(pixels_to_scan)
        end
        @rois << MrzReader::Roi.new(@roi)
        @roi = []
        clean_matrix
        start_pixel = get_start_pixel
      end

      @rois
    end

    def get_start_pixel
      x = @matrix.keys.first
      if x
        y = @matrix[x].first
        if y
          [x,y]
        end
      end
    end

    def get_pixels_to_scan pixels
      res = []
      pixels.each do |pixel|
        x, y = pixel
        if delete_pixel(x, y)
          res += surround_pixels(x,y)
        end
      end
      res
    end

    def delete_pixel x, y
      if @matrix[x] and @matrix[x].include?(y)
        @matrix[x].delete(y)
        @roi << [x, y]
        true
      end
    end

    def clean_matrix
      keys = @matrix.keys
      keys.each do |key|
        @matrix.delete(key) if !@matrix[key].any?
      end
    end

    def surround_pixels x, y
      [[x-1, y], [x+1, y], [x, y-1], [x, y+1]]
    end
  end
end
