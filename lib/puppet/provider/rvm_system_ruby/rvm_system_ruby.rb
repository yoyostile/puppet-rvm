Puppet::Type.type(:rvm_system_ruby).provide(:rvm) do
  desc "Ruby RVM support."

  commands :rvmcmd => "/usr/local/rvm/bin/rvm"
  
  ensurable
  
  def create
    rvmcmd "install", resource[:name]
  end

  def destroy
    rvmcmd "uninstall", resource[:name]
  end

  def exists?
    false
    #command = [command(:rvmcmd), "list", "strings"]
    #
    #begin
    #  execute(command).any? do |line|
    #    line =~ Regexp.new(Regexp.escape(resource[:name]))
    #  end
    #rescue Puppet::ExecutionFailure => detail
    #  raise Puppet::Error, "Could not list RVMs: #{detail}"
    #end

  end

  def default_use
    command = [command(:rvmcmd), "list", "default", "string"]
    begin
      execute(command).any? do |line|
        line =~ Regexp.new(Regexp.escape(resource[:name]))
      end
    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, "Could not list default RVM: #{detail}"
    end
  end

  def default_use=(value)
    if value
      rvmcmd "--default", "use", resource[:name]
    else
      rvmcmd "--default", "use", "system"
    end
  end
end
