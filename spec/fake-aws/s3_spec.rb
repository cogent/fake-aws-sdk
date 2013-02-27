require "fake_aws/s3"

describe FakeAWS::S3 do

  let(:fake_s3) { FakeAWS::S3.new }

  describe "#buckets" do

    it "starts empty" do
      fake_s3.buckets.should be_empty
    end

  end

end
