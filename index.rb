require 'lib/os'
require 'zlib'
require 'open3'

Shoes.app do
  stack do
    os = Os.new
    title "Install Super Nintendo Emulator for #{os.get_name}", size: 16
    button "Install" do
      dmg = "./lib/emulators/snes9x-1.53-macosx-113.dmg"
      mounted_dmg = "/Volumes/Snes9x 1.53/Snes9x.app"

      append { para "Mounting #{dmg}..." }

      Open3.popen2e("hdiutil", "mount", dmg) do |stdin, stdouterr, thread|
        stdouterr.each { |line| append { para line } }
      end

      append { para "Mount complete" }
      append { para "Copying Snes9x.app..." }

      Open3.popen2e("cp", "-R", mounted_dmg, "/Applications") do |stdin, stdouterr, thread|
        stdouterr.each { |line| append { para line } }
      end

      append { para "Copy complete" }
      append { para "Unmounting #{dmg}..." }

      Open3.popen2e("hdiutil", "unmount", dmg) do |stdin, stdouterr, thread|
        stdouterr.each { |line| append { para line } }
      end

      append { para "Unmount complete" }
    end
  end
end
