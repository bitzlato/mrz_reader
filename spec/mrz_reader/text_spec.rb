RSpec.describe MrzReader::Text do
  let(:subject) { MrzReader::Text.extract(lines) }


  context "TD1" do
    let(:lines) { ["IDD<<T220001293<<<<<<<<<<<<<<<", "6408125<2010315D<<<<<<<<<<<<<4", "MUSTERMANN<<ERIKA<PAULA<ANNA<<"] }

    it "extracts text" do
      expect(subject.valid?).to eq(true)
    end
  end

  context "TD2" do
    let(:lines) { ["I<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<", "D231458907UTO7408122F1204159<<<<<<<6"] }

    it "extracts text" do
      expect(subject.valid?).to eq(true)
    end
  end

  context "TD2" do
    let(:lines) { ["P<D<<ADENAUER<<KONRAD<HERMANN<JOSEPH<<<<<<<<", "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"] }

    it "extracts text" do
      expect(subject.valid?).to eq(true)
    end
  end
end
