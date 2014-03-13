require 'rexml/document'

actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :retry_count, :kind_of => Fixnum
attribute :timeout, :kind_of => Fixnum
attribute :username, :kind_of => String
attribute :domain, :kind_of => String
attribute :password, :kind_of => String
# 'begin' => 'IP', 'end' => 'IP'
attribute :ranges, :kind_of => Hash
# Array of IP address strings
attribute :specifics, :kind_of => Array
# Array of IPLIKE address strings ([0-9]{1,3}((,|-)[0-9]{1,3})*|\*)\.([0-9]{1,3}((,|-)[0-9]{1,3})*|\*)\.([0-9]{1,3}((,|-)[0-9]{1,3})*|\*)\.([0-9]{1,3}((,|-)[0-9]{1,3})*|\*)
attribute :ip_matches, :kind_of => Array

attr_accessor :exists