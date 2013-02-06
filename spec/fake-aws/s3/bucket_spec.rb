require "spec_helper"

require "fake_aws/s3/bucket"

describe FakeAWS::S3::Bucket do

  let(:bucket) { described_class.new("foo") }

  it "has a name" do
    bucket.name.should eq("foo")
  end

  let(:objects) { bucket.objects }

  describe "#objects" do

    it "starts empty" do
      objects.count.should be_zero
    end

  end

  describe "#objects['key']" do

    it "returns an S3Object" do
      objects["foo"].should be_kind_of(FakeAWS::S3::S3Object)
    end

    it "always returns the same S3Object" do
      objects["foo"].should equal(objects["foo"])
    end

    it "converts Symbol keys to String" do
      objects["foo"].should equal(objects[:foo])
    end

  end

end
