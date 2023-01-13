require "mrz_reader/version"
require "mrz_reader/image"
require "mrz_reader/roi"
require "mrz_reader/roi_manager"
require "mrz_reader/invalid_format_error"
require "mrz_reader/result"
require "mrz_reader/text"
require "mrz_reader/document/base"
require "mrz_reader/document/td1"
require "mrz_reader/document/td2"
require "mrz_reader/document/td3"

module MrzReader
  def self.parse(path)
    text = Image.parse(path)
    Text.parse(text)
  end

  def self.parse_image(path)
    Image.parse(path)
  end

  def self.parse_text text
    Text.parse(text)
  end
end
