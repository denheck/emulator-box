module Os
  class Installer
    def initialize(stack)
      @stack = stack
    end

    def out(text)
      @stack.app do
        append { para(text) }
      end
    end
  end
end
