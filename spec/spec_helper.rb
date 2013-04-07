require 'webrick'

Dir[File.dirname(__FILE__) + "/../app/**/*.rb"].each do |file|
  require file
end

include Medieval
include Controllers

class Model
  def self.method_added name
    if /hook/.match(name.to_s) or method_defined? "#{name}_without_hook"
      return
    end
    hook = """
    def #{name}_hook
      p 'Method #{name} has been called'
      #{name}_without_hook
    end
    """

    self.class_eval(hook)

    alias1 = "alias #{name}_without_hook #{name}"
    self.class_eval alias1

    alias2 = "alias #{name} #{name}_hook"
    self.class_eval alias2
  end
end
