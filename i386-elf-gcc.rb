require 'formula'

class I386ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-6.3.0/gcc-6.3.0.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-6.3.0/gcc-6.3.0.tar.bz2'
  sha256 'f06ae7f3f790fbf0f018f6d40e844451e6bc3b7bc96e128e63b09825c1f8b29f'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i386-elf-binutils'

  def install
    binutils = Formulary.factory 'i386-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-6'
    ENV['CXX'] = '/usr/local/bin/g++-6'
    ENV['CPP'] = '/usr/local/bin/cpp-6'
    ENV['LD'] = '/usr/local/bin/gcc-6'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-elf', '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers",
                             "--with-gmp=#{Formula["gmp"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc"].opt_prefix}"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i386-elf", prefix/"i386-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
