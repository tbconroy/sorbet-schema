# typed: strict

module Typed
  module Coercion
    module Coercer
      extend T::Sig
      extend T::Generic

      abstract!

      Target = type_member(:out)

      sig { abstract.params(field: Field, value: Value).returns(Result[Target, CoercionError]) }
      def coerce(field:, value:)
      end
    end
  end
end