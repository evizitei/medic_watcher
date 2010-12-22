require 'spec_helper'

describe Incident do
  subject { Incident.new }
  
  it { should be_a ActiveRecord::Base}
end