module Supercop
  module Parsers
    class ScssLint < Base
      private

      def parse
        output = JSON.parse(json)

        output.keys.inject(0) { |key, warnings| warnings + output[key].count }
      end
    end
  end
end
