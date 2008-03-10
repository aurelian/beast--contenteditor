module ContentEditor
  module PermalinkFu
    class << self
    
      def escape(str)
        s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
        s.gsub!(/\W+/, ' ') # all non-word chars to spaces
        s.strip!            # ohh la la
        s.downcase!         #
        s.gsub!(/\ +/, '-') # spaces to dashes, preferred separator char everywhere
        s
      end
    end
  end
end
