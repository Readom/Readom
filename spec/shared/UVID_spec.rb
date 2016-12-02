describe 'UVID' do

  it "always get the same UVID" do
    previous = UVID.uvid
    10.times do
      uvid = UVID.uvid
      uvid.should.equal previous
      uvid.size.should.equal 36 + UVID::PREFIX.length
      previous = uvid
    end
  end

end
