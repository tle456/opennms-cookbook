# frozen_string_literal: true
control 'dashlet_update' do
  describe wallboard('schlazorboard') do
    it { should exist }
    it { should be_default }
  end

  describe dashlet('summary2', 'schlazorboard') do
    it { should exist }
    its('dashlet_name') { should eq 'RTC' }
    its('boost_duration') { should eq 0 }
    its('boost_priority') { should eq 0 }
    its('duration') { should eq 15 }
    its('priority') { should eq 5 }
    its('parameters') { should eq 'timeslot' => '3600' }
  end
end
