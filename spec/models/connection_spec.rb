require 'spec_helper'

describe Connection do


  it "should generate a humanized list of options for select" do
    Connection.humanized_opts_for(:accessibility).should == { I18n.t('connections.evaluations.accessibility.low') => 1, I18n.t('connections.evaluations.accessibility.high') => 2 }
  end


end
