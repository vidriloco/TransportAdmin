module TransportsHelper
  
  def count_humanized_with(translation, count)
    html="<span class=\"number\">"
    if count==1
      html << t("#{translation}.one", :number => count)
    else
      html << t("#{translation}.other", :number => count)
    end
    html << "</span>"
  end
end