module Mint
  class TypeChecker
    type_error StringLiteralInterpolationTypeMismatch

    def check(node : Ast::HereDoc) : Checkable
      if node.modifier == '#'
        node.value.each do |item|
          case item
          when Ast::Node
            item_type =
              resolve item

            raise TypeError, {
              "expected" => HTML,
              "got"      => item_type,
              "node"     => item,
            } unless Comparer.matches_any?(item_type, [STRING, NUMBER, HTML])
          end
        end

        HTML
      else
        node.value.each do |item|
          case item
          when Ast::Node
            item_type =
              resolve item

            raise StringLiteralInterpolationTypeMismatch, {
              "expected" => STRING,
              "got"      => item_type,
              "node"     => item,
            } unless Comparer.matches_any?(item_type, [STRING, NUMBER])
          end
        end

        STRING
      end
    end

    def check(node : Ast::StringLiteral) : Checkable
      node.value.each do |item|
        case item
        when Ast::Node
          item_type =
            resolve item

          raise StringLiteralInterpolationTypeMismatch, {
            "expected" => STRING,
            "got"      => item_type,
            "node"     => item,
          } unless Comparer.matches_any?(item_type, [STRING, NUMBER])
        end
      end

      STRING
    end
  end
end
