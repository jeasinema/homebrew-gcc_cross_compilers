require 'formula'

class I386ElfGdb < Formula
  homepage 'http://www.gnu.org/software/gdb/'
  url 'http://ftp.gnu.org/gnu/gdb/gdb-7.12.1.tar.xz'
  sha256 "4607680b973d3ec92c30ad029f1b7dbde3876869e6b3a117d8a7e90081113186"

  depends_on 'i386-elf-binutils'
  depends_on 'i386-elf-gcc'

  def install
    # ENV['CC'] = '/usr/local/bin/gcc-4.9'
    # ENV['CXX'] = '/usr/local/bin/g++-4.9'
    # ENV['CPP'] = '/usr/local/bin/cpp-4.9'
    # ENV['LD'] = '/usr/local/bin/gcc-4.9'

    mkdir 'build' do
      system '../configure', '--target=i386-elf', "--prefix=#{prefix}", '--disable-werror'
      system 'make'
      system 'make install'
      #FileUtils.rm_rf share/"locale"
      #FileUtils.mv lib, libexec
    end
  end
end
