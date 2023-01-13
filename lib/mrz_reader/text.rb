module MrzReader
  class Text
    attr_accessor :lines

    def self.extract lines
      self.new(lines).extract
    end

    def initialize lines
      @lines = lines
    end

    def extract
      determine_type
      case determine_type
      when :td1
        Document::TD1.parse(lines)
      when :td2
        Document::TD2.parse(lines)
      when :td3
        Document::TD3.parse(lines)
      end
    end

    private

    def determine_type
      if lines.size == 3
        :td1
      elsif lines.size == 2 && lines.first.size == 36
        :td2
      elsif lines.size == 2 && lines.first.size == 44
        :td3
      else
        raise InvalidFormatError, "invalid or unsupported mrz code given"
      end
    end
  end
end