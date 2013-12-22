require 'lib/os/installer/installer'
require 'open3'

module Os
  class MacInstaller < Os::Installer
    class MacInstallerError < StandardError
    end

    def initialize(stack)
      super(stack)

      @emulator = "./lib/emulators/snes9x-1.53-macosx-113.dmg"
      @mounted_emulator = "/Volumes/Snes9x 1.53/Snes9x.app"
    end

    def install
      mount_dmg
      copy_dmg
      unmount_dmg
    end

    def mount_dmg
      Open3.popen2e("hdiutil", "mount", @emulator) do |stdin, stdouterr, thread|
        # TODO: create new thread to append output to GUI
        while line = stdouterr.gets
          out line
        end

        unless thread.value.success?
          raise self::DetectionError, "Failed to mount #{@emulator}"
        end
      end

      out "Mount complete"
    end

    def copy_dmg
      out "Copying Snes9x.app..."

      Open3.popen2e("cp", "-R", @mounted_emulator, "/Applications") do |stdin, stdouterr, thread|
        stdouterr.each { |line| out line }
      end

      out "Copy complete"
    end

    def unmount_dmg
      out "Unmounting #{@mounted_emulator}..."

      Open3.popen2e("hdiutil", "unmount", @mounted_emulator) do |stdin, stdouterr, thread|
        stdouterr.each { |line| out line }
      end

      out "Unmount complete"
    end
  end
end
