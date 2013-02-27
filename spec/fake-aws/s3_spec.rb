require "fake_aws/s3"

describe FakeAWS::S3 do

  let(:fake_s3) { FakeAWS::S3.new }

  let(:buckets) { fake_s3.buckets }

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
