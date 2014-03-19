def whyrun_supported?
    true
end

use_inline_resources

action :create do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Create #{ @new_resource }") do
      create_command
      new_resource.updated_by_last_action(true)
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::OpennmsNotificationCommand.new(@new_resource.name)
  @current_resource.name(@new_resource.name)

  if command_exists?(@current_resource.name)
    @current_resource.exists = true
  end
end

private

def command_exists?(name)
  Chef::Log.debug "Checking to see if this command exists: '#{ name }'"
  file = ::File.new("#{node['opennms']['conf']['home']}/etc/notificationCommands.xml", "r")
  doc = REXML::Document.new file
  file.close
  !doc.elements["/notification-commands/command/name[text() = '#{name}']"].nil?
end

def create_command
  Chef::Log.debug "Creating notification command : '#{ new_resource.name }'"
  file = ::File.new("#{node['opennms']['conf']['home']}/etc/notificationCommands.xml", "r")
  contents = file.read
  doc = REXML::Document.new(contents, { :respect_whitespace => :all })
  doc.context[:attribute_quote] = :quote
  file.close

  command_el = doc.root.add_element 'command', { 'binary' => new_resource.binary }
  name_el = command_el.add_element 'name'
  name_el.add_text new_resource.name
  execute_el = command_el.add_element 'execute' 
  execute_el.add_text new_resource.execute
  if !new_resource.comment.nil?
    comment_el = command_el.add_element 'comment'
    comment_el.add_text new_resource.comment
  end
  if !new_resource.arguments.nil?
    new_resource.arguments.each do |arg|
      arg_el = command_el.add_element 'argument', { 'streamed' => "#{arg['streamed']}" }
      if !arg['substitution'].nil?
        sub_el = arg_el.add_element 'substitution'
        sub_el.add_text arg['substitution']
      end
      if !arg['switch'].nil?
        switch_el = arg_el.add_element 'switch'
        switch_el.add_text arg['switch']
      end
    end
  end

  out = ""
  formatter = REXML::Formatters::Pretty.new(2)
  formatter.compact = true
  formatter.write(doc, out)
  ::File.open("#{node['opennms']['conf']['home']}/etc/notificationCommands.xml", "w"){ |file| file.puts(out) }

end