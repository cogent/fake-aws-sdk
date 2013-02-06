require "spec_helper"

require "fake_aws/s3/bucket"

describe FakeAWS::S3::Bucket do

  let(:bucket) { described_class.new("foo") }

  it "has a name" do
    bucket.name.should eq("foo")
  end

  describe "#objects" do

    let(:objects) { bucket.objects }

    it "starts empty" do
      objects.count.should be_zero
    end

  end

  describe "#objects['key']" do

    let(:result) { bucket.objects["foo"] }

    it "returns an S3Object" do
      result.should_not be_nil
      result.should be_kind_of(FakeAWS::S3::S3Object)
    end

    it "always returns the same S3Object" do
      result.should equal(bucket.objects["foo"])
    end

  end

end
