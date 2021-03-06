require "fake_aws/s3/bucket_collection"

describe FakeAWS::S3::BucketCollection do

  let(:buckets) { FakeAWS::S3::BucketCollection.new }

  describe "#[]" do

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

  it "is Enumerable" do
    buckets.should be_kind_of(Enumerable)
  end

  describe "#each" do
    it "yields all buckets in alphabetical order" do
      buckets["c"]
      buckets["a"]
      buckets["b"]
      buckets.map(&:name).should eq(%w(a b c))
    end
  end

  describe "#create" do

    before do
      buckets.create("sydney-bucket", :location_constraint => "ap-southeast-2")
    end

    it "creates a Bucket" do
      buckets.first.name.should eq("sydney-bucket")
    end

    it "records the location_constraint" do
      buckets["sydney-bucket"].location_constraint.should eq("ap-southeast-2")
    end

  end

end
