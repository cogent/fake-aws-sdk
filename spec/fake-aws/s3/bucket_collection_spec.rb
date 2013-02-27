require "fake_aws/s3/bucket_collection"

describe FakeAWS::S3::BucketCollection do

  let(:buckets) { FakeAWS::S3::BucketCollection.new }

  describe "#buckets" do

    it "starts empty" do
      buckets.should be_empty
    end

  end

  describe "#buckets['name']" do

    it "returns a Bucket" do
      buckets["foo"].should be_kind_of(FakeAWS::S3::Bucket)
    end

    it "always returns the same Bucket" do
      buckets["foo"].should equal(buckets["foo"])
    end

    it "converts Symbol names to String" do
      buckets["foo"].should equal(buckets[:foo])
    end

  end
end
