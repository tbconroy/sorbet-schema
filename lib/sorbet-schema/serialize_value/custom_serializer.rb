# typed: strict

class SerializeValue
  class CustomSerializer
    extend T::Sig
    extend T::Generic

    abstract!

    sig { abstract.returns(T::Types::Base) }
    def type
    end

    sig { params(value: Typed::Value).returns(T::Boolean) }
    def used_for_value?(value)
      value.is_a?(type)
    end

    sig { abstract.params(value: Typed::Value).returns(Typed::Result[String, Typed::SerializationError]) }
    def serialize(value)
    end
  end
end
