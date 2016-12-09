describe Youmagine::Design do
  context "all" do
    it "returns a list of designs and defaults to the first page" do
      VCR.use_cassette "youmagine_designs_all" do
        designs = Youmagine::Design.all

        expect(designs.first.id).to eq 14712
        expect(designs.first.name).to eq "Stryfe 180 Motor Cover"
        expect(designs.first.image).to include(:original, :small, :medium, :large)
        expect(designs.first.image[:small]).to eq "https://s3-eu-west-1.amazonaws.com/files.youmagine.com/uploads/image/file/155054/small_jamrendering_14712_5219420161209-18447-bsqu24.png"
        expect(designs.current_page).to eq 1
      end
    end

    it "requests a specific page" do
      VCR.use_cassette "youmagine_designs_page_5" do
        designs = Youmagine::Design.all(page: 5)

        expect(designs.current_page).to eq 5
      end
    end

    it "limits the amount of results" do
      VCR.use_cassette "youmagine_designs_limit" do
        designs = Youmagine::Design.all(limit: 10)

        expect(designs.per_page).to eq 10
      end
    end
  end

  context "find" do
    it "returns a single design retrieved by id" do
      VCR.use_cassette "youmagine_designs_find" do
        design = Youmagine::Design.find(14712)

        expect(design.id).to eq 14712
        expect(design.name).to eq "Stryfe 180 Motor Cover"
        expect(design.image).to include(:original, :small, :medium, :large)
        expect(design.image[:small]).to eq "https://s3-eu-west-1.amazonaws.com/files.youmagine.com/uploads/image/file/155054/small_jamrendering_14712_5219420161209-18447-bsqu24.png"
      end
    end
  end

end
