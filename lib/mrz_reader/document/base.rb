module MrzReader
  module Document
    class Base
      SPECIAL_CHAR = "<"
      WHITESPACE = " "
      EMPTY_SPACE = ""

      private

      def special_char_to_empty_space(str)
        str.gsub(SPECIAL_CHAR, EMPTY_SPACE)
      end

      def special_char_to_white_space(str)
        str.gsub(SPECIAL_CHAR, WHITESPACE)
      end
    end
  end
end