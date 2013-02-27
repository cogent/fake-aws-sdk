require "fake_aws/s3"

describe FakeAWS::S3 do

  let(:fake_s3) { FakeAWS::S3.new }

  describe "#buckets" do

    it "returns a BucketCollection" do
      fake_s3.buckets.should be_kind_of(FakeAWS::S3::BucketCollection)
    end

  end

end
