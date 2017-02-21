require 'formula'

class I386ElfBinutils < Formula
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.gz"
  sha256 "26253bf0f360ceeba1d9ab6965c57c6a48a01a8343382130d1ed47c468a3094f"


  depends_on 'gcc' => :build

  def install
    ENV['CC'] = '/usr/local/bin/gcc-6'
    ENV['CXX'] = '/usr/local/bin/g++-6'
    ENV['CPP'] = '/usr/local/bin/cpp-6'
    ENV['LD'] = '/usr/local/bin/gcc-6'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-elf',
                             '--disable-werror',
                             '--enable-gold=yes',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end
