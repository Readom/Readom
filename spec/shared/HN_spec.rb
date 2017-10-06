describe 'HN' do

  describe '#shared_instance' do

    it "is a HN instance" do
      HN.shared_instance.should.be.instance_of HN
    end
  end
end
