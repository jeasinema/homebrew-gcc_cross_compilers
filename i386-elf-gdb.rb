require 'formula'

class UniversalBrewedPython < Requirement
  satisfy { archs_for_command("python").universal? }

  def message; <<-EOS.undent
    A build of GDB using a brewed Python was requested, but Python is not
    a universal build.
    GDB requires Python to be built as a universal binary or it will fail
    if attempting to debug a 32-bit binary on a 64-bit host.
    EOS
  end
end

class I386ElfGdb < Formula
  homepage 'http://www.gnu.org/software/gdb/'
  url 'http://ftp.gnu.org/gnu/gdb/gdb-7.12.1.tar.xz'
  sha256 "4607680b973d3ec92c30ad029f1b7dbde3876869e6b3a117d8a7e90081113186"

  depends_on 'i386-elf-binutils'
  depends_on 'i386-elf-gcc'
  depends_on UniversalBrewedPython

  def install
    # ENV['CC'] = '/usr/local/bin/gcc-4.9'
    # ENV['CXX'] = '/usr/local/bin/g++-4.9'
    # ENV['CPP'] = '/usr/local/bin/cpp-4.9'
    # ENV['LD'] = '/usr/local/bin/gcc-4.9'

    mkdir 'build' do
      system '../configure', '--target=i386-elf', "--prefix=#{prefix}", '--disable-werror', "--with-python=#{HOMEBREW_PREFIX}"
      system 'make'
      system 'make install'
      #FileUtils.rm_rf share/"locale"
      #FileUtils.mv lib, libexec
    end
  end
end
