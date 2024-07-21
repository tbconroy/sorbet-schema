# typed: strict

require "singleton"

class SerializeValue
  class CustomSerializerRegistry
    extend T::Sig

    include Singleton

    Registry = T.type_alias { T::Array[T.class_of(CustomSerializer)] }

    sig { void }
    def initialize
      @available = T.let([], Registry)
    end

    sig { params(serializer: T.class_of(CustomSerializer)).void }
    def register(serializer)
      @available.prepend(serializer)
    end

    sig { void }
    def reset!
      @available = []
    end

    sig { params(value: Typed::Value).returns(T.nilable(T.class_of(CustomSerializer))) }
    def select_serializer_by(value:)
      @available.find { |serializer| serializer.new.used_for_value?(value) }
    end
  end
end
