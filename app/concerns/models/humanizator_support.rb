module Models::HumanizatorSupport
  
  module ClassMethods
    def humanized_opts_for(type)
      opts=self.send("#{type.to_s}_opts")
      results=opts.each_key.inject({}) do |collected, last|
        collected[I18n.t("selectable_options.#{type.to_s}.#{opts[last]}")] = last
        collected
      end
      results
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  
end