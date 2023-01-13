RSpec.describe MrzReader::Image do
  let(:subject) { MrzReader::Image.parse(File.absolute_path("./fixtures/samples/#{image}"), debug) }

  describe "with debug on" do
    let(:debug) { true }

    describe "td1 image" do
      let(:image) { "td1.jpeg" }

      it "parses text" do
        expect(subject).to eq(["I<HUN000017AE<2<<<<<<<<<<<<<<<", "7908150F2201041HUN<<<<<<<<<<<6", "MESZAROS<<BRIGITTA<ERZSEBET<<<"])
      end
    end

  end

  describe "with debug off" do
    let(:debug) { false }

    describe "russian image" do
      let(:image) { "russian.jpeg" }

      it "parses text" do
        expect(subject).to eq(["P<RUSIVANOV<<IVAN<<<<<<<<<<<<<<<<<<<<<<<<<<<", "1234567897RUS8610164M2512152<<<<<<<<<<<<<<04"])
      end
    end

    describe "russian bio image" do
      let(:image) { "russian_bio.jpeg" }

      it "parses text" do
        expect(subject).to eq(["P<RUSIVANOV<<IVAN<<<<<<<<<<<<<<<<<<<<<<<<<<<", "1234567897RUS8610164M3012154<<<<<<<<<<<<<<02"])
      end
    end

    describe "russian rotated images" do
      let(:image) { "russian_rotated.jpeg" }

      it "parses text" do
        expect(subject).to eq(["P<RUSIVANOV<<IVAN<<<<<<<<<<<<<<<<<<<<<<<<<<<", "1234567897RUS8610164M2512152<<<<<<<<<<<<<<04"])
      end
    end

    describe "poor image" do
      let(:image) { "poor.jpeg" }

      it "parses text" do
        expect(subject).not_to eq(nil)
      end
    end

    describe "mr bean image" do
      let(:image) { "mrbean.jpeg" }

      it "parses text" do
        expect(subject).to eq(["P<GB<MR<BEAN<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<", "023477812GBR8111063M0004422<<<<<<<<<<<<<<<<<<<06"])
      end
    end

    describe "noisy image" do
      let(:image) { "noisy.jpeg" }

      it "parses text" do
        expect(subject).to eq(["P<CZESPECIMEN<<VZOR<<<<<<<<<<<<<<<<<<<<<<<<<", "99006000<8CZE1102299F16090641152291111<<<<24"])
      end
    end

    describe "td3 image" do
      let(:image) { "td3.jpeg" }

      it "parses text" do
        expect(subject).to eq(["P<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<", "L898902C36UTO7408122F1204159ZE184226B<<<<<10"])
      end
    end

    describe "td2 image" do
      let(:image) { "td2.jpeg" }

      it "parses text" do
        expect(subject).to eq(["I<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<", "D231458907UTO7408122F1204159<<<<<<<6"])
      end
    end

    describe "australia image" do
      let(:image) { "australia.jpeg" }

      it "parses text" do
        expect(subject).to eq(["P<AUSCITIZEN<<JANE<<<<<<<<<<<<<<<<<<<<<<<<<<", "PA09404433AUS8406077F1903212<17332717P<<<<68"])
      end
    end

    describe "rotated images" do
      let(:image) { "rotated.jpeg" }

      it "parses text" do
        expect(subject).to eq(["P<AUSCITIZEN<<JANE<<<<<<<<<<<<<<<<<<<<<<<<<<", "PA09404433AUS8406077F1903212<17332717P<<<<68"])
      end
    end
  end
end
