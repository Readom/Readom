describe 'HN' do

  it "HN shared_instance" do
    HN.shared_instance.should.be.instance_of HN

  end
end
