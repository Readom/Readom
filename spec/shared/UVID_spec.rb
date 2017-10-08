describe 'UVID' do

  describe '.uvid' do

    it "get the same uvid value" do
      previous = UVID.uvid

      3.times do
        uvid = UVID.uvid
        uvid.should.equal previous
        uvid.size.should.equal 36 + UVID::PREFIX.length
        previous = uvid
      end
    end
  end

end
