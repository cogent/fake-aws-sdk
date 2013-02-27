require "fake_aws/s3/object_collection"

describe FakeAWS::S3::ObjectCollection do

  let(:objects) { FakeAWS::S3::ObjectCollection.new }

  it "starts empty" do
    objects.should be_empty
  end

  describe "#[]" do

    it "returns an S3Object" do
      objects["foo"].should be_kind_of(FakeAWS::S3::S3Object)
    end

    it "always returns the same S3Object" do
      objects["foo"].should equal(objects["foo"])
    end

    it "passes along the object key" do
      objects["foo"].key.should eq("foo")
    end

    it "converts Symbol keys to String" do
      objects["foo"].should equal(objects[:foo])
    end

  end

end
