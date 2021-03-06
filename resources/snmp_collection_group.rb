# frozen_string_literal: true
require 'rexml/document'

# Defines data to collect in an SNMP collection in
# $ONMS_HOME/etc/datacollection-config.xml. The collection_name must
# reference an existing collection defined by the snmp_collection LWRP.
# This LWRP follows the new 1.8.4+ modular configuration where you specify
# groups and systemDef definitions in a separate file and include them
# in the main $ONMS_HOME/etc/datacollection-config.xml file with
# include-collection elements. The files are expected to be generated
# using the new MIB compiler included in 1.12 and as such there is no
# LWRP to define those files. Instead, put the generated file either
# in your cookbook or make it available at some URL. Then reference it with
# the file attribute of this LWRP (and use the source parameter if using an
# external location).
# The system_def and exclude_filters attributes allow you to configure
# the allowed systemDefs in a flexible manner as outlined in
# http://www.opennms.org/wiki/Data_Collection_Configuration_How-To#Modular_Configuration

actions :create, :delete
default_action :create

# this is used for group_name when group_name is nil
attribute :group, name_attribute: true, kind_of: String, required: true
attribute :group_name, kind_of: String, required: false
attribute :collection_name, kind_of: String, default: 'default', required: true
attribute :file, kind_of: String, required: false # There's a use case where the file is created automatically with the jdbc_query resource in which case this won't get used.
# set to the URL of your data collection file if not stored in your cookbook
attribute :source, kind_of: String, default: 'cookbook_file'
attribute :system_def, kind_of: String
attribute :exclude_filters, kind_of: Array, default: []

attr_accessor :exists
