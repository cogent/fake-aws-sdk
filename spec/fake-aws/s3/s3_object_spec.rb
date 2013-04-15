require "fake_aws/s3/bucket"
require "fake_aws/s3/s3_object"

describe FakeAWS::S3::S3Object do

  let(:bucket) { FakeAWS::S3::Bucket.new("foo") }
  let(:other_bucket) { FakeAWS::S3::Bucket.new("bar") }

  let(:object) { bucket.objects["test-object"] }

  subject { object }

  describe "#key" do
    it "returns the object key" do
      subject.key.should eq("test-object")
    end
  end

  context "before it has been written" do

    it { should_not exist }

    describe "#read" do

      it "raises a KeyError" do
        lambda { object.read }.should raise_error(KeyError)
      end

    end

    describe "#content_length" do

      it "raises a KeyError" do
        lambda { object.content_length }.should raise_error(KeyError)
      end

    end

  end

  context "after being written" do

    let(:data) { "foobarbaz" }

    before do
      object.write(data)
    end

    it { should exist }

    describe "#read" do

      it "returns the data written" do
        object.read.should eq(data)
      end

      context "with a block" do

        let(:data) { "foo\nbar\n" }

        it "yields data, line-by-line" do
          @chunks = []
          object.read do |chunk|
            @chunks << chunk
          end
          @chunks.should eq(["foo\n", "bar\n"])
        end

      end

    end

    describe "#content_length" do

      it "returns the size of data written" do
        object.content_length.should eq(data.length)
      end

    end

  end

  context "after being deleted" do

    before do
      object.write("whatever")
      object.delete
    end

    it { should_not exist }

    describe "#read" do

      it "raises a KeyError" do
        lambda { object.read }.should raise_error(KeyError)
      end

    end

  end

  describe "#write" do

    context "with an IO object" do

      let(:data) { "stream-of-stuff" }

      before do
        object.write(StringIO.new(data))
      end

      it "saves the streamed data" do
        object.read.should eq(data)
      end

    end

  end

  describe "#copy_to" do

    before do
      object.write("CONTENT")
    end

    context "with a target S3Object" do

      let(:target_object) { other_bucket.objects["target"] }

      before do
        object.copy_to(target_object)
      end

      it "copies the object" do
        target_object.read.should eq("CONTENT")
      end

    end

    context "with a target key" do

      before do
        object.copy_to("dupe")
      end

      it "copies within the existing bucket" do
        object.bucket.objects["dupe"].read.should eq("CONTENT")
      end

    end

    context "with a target key, and a :bucket" do

      before do
        object.copy_to("dupe", :bucket => other_bucket)
      end

      it "copies to the specified bucket" do
        other_bucket.objects["dupe"].read.should eq("CONTENT")
      end

    end

  end

  describe "#copy_from" do

    let(:source_object) { other_bucket.objects["source"] }

    before do
      source_object.write("CONTENT")
    end

    context "with a source S3Object" do

      before do
        object.copy_from(source_object)
      end

      it "copies the object" do
        object.read.should eq("CONTENT")
      end

    end

    context "with a source key" do

      let(:source_object) { bucket.objects["source"] }

      before do
        object.copy_from("source")
      end

      it "copies within the existing bucket" do
        object.read.should eq("CONTENT")
      end

    end

    context "with a target key, and a :bucket" do

      before do
        object.copy_from("source", :bucket => other_bucket)
      end

      it "copies from the specified bucket" do
        object.read.should eq("CONTENT")
      end

    end

  end

end
