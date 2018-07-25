# frozen_string_literal: true
control 'threshold_change_descr' do
  espresso = {
    'ds_name' => 'espresso',
    'group' => 'coffee',
    'type' => 'low',
    'ds_type' => 'if',
    'filter_operator' => 'and',
    'resource_filters' => [{ 'field' => 'ifHighSpeed', 'filter' => '^[1-9]+[0-9]*$' }],
  }
  describe threshold(espresso) do
    it { should exist }
    its('description') { should eq 'alarm when BEC too low' }
  end
end
