require 'lib/os/detect'
require 'lib/os/installer/linux_installer'
require 'lib/os/installer/mac_installer'
require 'lib/os/installer/windows_installer'

module Os
  class InstallerFactory
    def initialize(stack)
      @stack = stack
      @detect = Os::Detect.new
    end

    def install
      if @detect.is_windows?
        Os::WindowsInstaller.new(@stack).install
      elsif @detect.is_mac?
        Os::MacInstaller.new(@stack).install
      elsif @detect.is_linux?
        Os::LinuxInstaller.new(@stack).install
      end
    end
  end
end
