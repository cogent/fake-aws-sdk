require "fake_aws/s3/bucket"

describe FakeAWS::S3::Bucket do

  let(:bucket) { described_class.new("foo") }

  it "has a name" do
    bucket.name.should eq("foo")
  end

  it "implicitly exists" do
    bucket.should exist
  end

  it "starts empty" do
    bucket.should be_empty
  end

  describe "#objects" do

    it "returns an ObjectCollection" do
      bucket.objects.should be_kind_of(FakeAWS::S3::ObjectCollection)
    end

  end

end
