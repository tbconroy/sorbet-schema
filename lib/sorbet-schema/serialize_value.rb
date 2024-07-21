# typed: strict

class SerializeValue
  extend T::Sig

  sig { params(custom_serializer: T.class_of(CustomSerializer)).void }
  def self.register_custom_serializer(custom_serializer)
    CustomSerializerRegistry.instance.register(custom_serializer)
  end

  sig { params(value: T.untyped).returns(T.untyped) }
  def self.serialize(value)
    custom_serializer = CustomSerializerRegistry.instance.select_serializer_by(value:)

    if custom_serializer
      custom_serializer.new.serialize(value).payload_or(value)
    elsif value.is_a?(Hash)
      HashTransformer.serialize_values(value)
    elsif value.is_a?(Array)
      value.map { |item| serialize(item) }
    elsif value.is_a?(T::Struct)
      value.serialize_to(:hash).payload_or(value)
    elsif value.respond_to?(:serialize)
      value.serialize
    else
      value
    end
  end
end
