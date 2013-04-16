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

  describe "#location_constraint" do

    it "defaults to nil" do
      bucket.location_constraint.should be_nil
    end

  end

  context "containing objects" do

    before do
      bucket.objects["foo"].write("FOO")
      bucket.objects["bar"].write("BAR")
    end

    describe "#clear!" do

      before do
        bucket.clear!
      end

      it "deletes all the things" do
        bucket.should be_empty
      end

    end

  end

  context "with a location_constraint" do

    let(:bucket) { described_class.new("foo", :location_constraint => "over-there") }

    it "exposes the specified #location_constraint" do
      bucket.location_constraint.should eq("over-there")
    end

  end

end
