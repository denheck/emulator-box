require 'lib/os/installer_factory'

class EmulatorBox
  def initialize(stack)
    @stack = stack
    splash
  end

  def splash
    install_method = method(:install)

    @stack.app do
      append do
        title("Welcome to Emulator Box!")
        button("Play")

        button("Install", &install_method)
      end
    end
  end

  def install(btn)
    Os::InstallerFactory.new(@stack).install
  end
end
