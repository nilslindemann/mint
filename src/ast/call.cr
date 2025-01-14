module Mint
  class Ast
    class Call < Node
      getter arguments, expression

      def initialize(@arguments : Array(Expression),
                     @expression : Expression,
                     @input : Data,
                     @from : Int32,
                     @to : Int32)
      end
    end
  end
end
