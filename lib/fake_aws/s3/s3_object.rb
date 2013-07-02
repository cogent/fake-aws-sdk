module FakeAWS
  class S3

    class S3Object

      def initialize(bucket, key)
        @bucket = bucket
        @key = key
      end

      attr_reader :bucket
      attr_reader :key

      def write(data, options = {})
        data = data.read if data.respond_to?(:read)
        @data = data
      end

      def read
        must_exist!
        if block_given?
          @data.each_line do |line|
            yield line
          end
        end
        @data
      end

      def copy_to(target, options = {})
        resolve_object_reference(target, options).write(self.read)
      end

      def copy_from(source, options = {})
        write(resolve_object_reference(source, options).read)
      end

      def content_length
        must_exist!
        @data.length
      end

      def exists?
        !!@data
      end

      def delete
        @data = nil
      end

      private

      def must_exist!
        raise KeyError unless exists?
      end

      def resolve_object_reference(ref, options)
        if ref.is_a?(S3Object)
          ref
        else
          bucket = case
          when options.has_key?(:bucket)
            options[:bucket]
          when options.has_key?(:bucket_name)
            raise NotImplementError, "please specify :bucket"
          else
            self.bucket
          end
          bucket.objects[ref]
        end
      end

    end

  end
end
