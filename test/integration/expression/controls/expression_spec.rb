# frozen_string_literal: true
control 'expression' do
  describe expression('cheftest', 'icmp / 1000', 'if', 'high', 'and', [{ 'field' => 'ifHighSpeed', 'filter' => '^[1-9]+[0-9]*$' }]) do
    it { should exist }
    its('relaxed') { should be false }
    its('description') { should eq 'ping latency too high expression' }
    its('value') { should eq 20.0 }
    its('rearm') { should eq 18.0 }
    its('trigger') { should eq 3 }
    its('triggered_uei') { should eq 'uei.opennms.org/thresholdTest/testThresholdExceeded' }
    its('rearmed_uei') { should eq 'uei.opennms.org/thresholdTest/testThresholdRearmed' }
  end
end
