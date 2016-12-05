

describe Youmagine::Design do
  context "all" do
    it "returns designs" do
      VCR.use_cassette "youmagine_designs_all" do
        designs = Youmagine::Design.all

        byebug
      end
    end
  end

end
