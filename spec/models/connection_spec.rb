require 'spec_helper'

describe Connection do


  it "should generate a humanized list of options for select" do
    Connection.humanized_opts_for(:length).should == { I18n.t('selectable_options.length.short') => 1, I18n.t('selectable_options.length.medium') => 2, I18n.t('selectable_options.length.large') => 3 }
  end


end
