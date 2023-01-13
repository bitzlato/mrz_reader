module MrzReader
  module Document
    class TD1 < Base
      FORMAT_ONE = /\A(.{2})(.{3})(.{9})(\d)(.{15})\z/
      FORMAT_TWO = /\A(\d{6})(\d)(.)(\d{6})(\d)(.{3})(.{11})(\d)\z/
      FORMAT_THREE = /\A([^<]+)<<(.+)\z/

      attr_reader :lines, :line_one, :line_two, :line_three

      def self.parse lines
        self.new(lines).parse
      end

      def initialize lines
        @lines = lines
        @line_one  = lines[0]
        @line_two  = lines[1]
        @line_three = lines[2]
      end

      def parse
        if @lines.size != 3
          raise InvalidFormatError, "td1 requires 3 mrz lines"
        end

        line_one_matches = FORMAT_ONE.match(@line_one)
        line_two_matches = FORMAT_TWO.match(@line_two)
        line_three_matches = FORMAT_THREE.match(@line_three)

        if line_one_matches.nil?
          raise InvalidFormatError, "td1 first line does not match the required format"
        end

        if line_two_matches.nil?
          raise InvalidFormatError, "td1 second line does not match the required format"
        end

        if @line_three.size != 30 || line_three_matches.nil?
          raise InvalidFormatError, "td1 third line does not match the required format"
        end

        Result.new(
          birth_date: line_two_matches[1],
          birth_date_check_digit: line_two_matches[2],
          composite_check_digit: line_two_matches[8],
          document_code: special_char_to_empty_space(line_one_matches[1]),
          document_number: special_char_to_empty_space(line_one_matches[3]),
          document_number_check_digit: line_one_matches[4],
          expiration_date: line_two_matches[4],
          expiration_date_check_digit: line_two_matches[5],
          first_name: special_char_to_white_space(line_three_matches[2]).strip,
          issuing_state: special_char_to_empty_space(line_one_matches[2]),
          last_name: line_three_matches[1],
          nationality: special_char_to_empty_space(line_two_matches[6]),
          optional1: special_char_to_empty_space(line_one_matches[5]),
          optional2: special_char_to_empty_space(line_two_matches[7]),
          sex: special_char_to_empty_space(line_two_matches[3]),
          type: :td1,
        )
      end
    end
  end
end