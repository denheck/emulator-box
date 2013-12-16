require 'rbconfig'

class Os
  class DetectionError < StandardError
  end

  def initialize
    @os ||= get_os
  end

  def get_name
    @os.to_s
  end

  def get_os
    host_os = RbConfig::CONFIG['host_os']
    case host_os
    when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
      :windows
    when /darwin|mac os/
      :macosx
    when /linux/
      :linux
    else
      raise self::DetectionError, "unknown os: #{host_os.inspect}"
    end
  end

  def is_windows?
    @os === :windows
  end

  def is_mac?
    @os === :macosx
  end

  def is_linux?
    @os === :linux
  end
end
