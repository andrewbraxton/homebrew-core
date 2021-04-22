class Libxmlsec1 < Formula
  desc "XML security library"
  homepage "https://www.aleksey.com/xmlsec/"
  url "https://www.aleksey.com/xmlsec/download/xmlsec1-1.2.32.tar.gz"
  sha256 "e383702853236004e5b08e424b8afe9b53fe9f31aaa7a5382f39d9533eb7c043"
  license "MIT"

  livecheck do
    url "https://www.aleksey.com/xmlsec/download/"
    regex(/href=.*?xmlsec1[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "03549710a64505e61e3e185998a92df43b577bb494cce4ffab915301f149b19a"
    sha256 cellar: :any, big_sur:       "af7411c43a003e9e77219c4b00857b0f99a75546426750ad0aff1e1e5b6cfa41"
    sha256 cellar: :any, catalina:      "c802faa7f7b56c286aa82b9c5d2041b19513848c54cd8f8b2d55e62c810cd247"
    sha256 cellar: :any, mojave:        "cde9ec0c2240211d002b575f17028ff43284c6f47fbe26ecf9fa131aa94a373c"
    sha256 cellar: :any, high_sierra:   "bf6bdda2fb39e06e3db72e491fdb0327aab691b15cc8e47a1c5eb74828356d2b"
  end

  depends_on "pkg-config" => :build
  depends_on "gnutls" # Yes, it wants both ssl/tls variations
  depends_on "libgcrypt"
  depends_on "libxml2"
  depends_on "openssl@1.1"

  on_macos do
    depends_on xcode: :build
  end

  # Add HOMEBREW_PREFIX/lib to dl load path
  patch :DATA

  def install
    args = ["--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--disable-crypto-dl",
            "--disable-apps-crypto-dl",
            "--with-openssl=#{Formula["openssl@1.1"].opt_prefix}"]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/xmlsec1", "--version"
    system "#{bin}/xmlsec1-config", "--version"
  end
end

__END__
diff --git a/src/dl.c b/src/dl.c
index 6e8a56a..0e7f06b 100644
--- a/src/dl.c
+++ b/src/dl.c
@@ -141,6 +141,7 @@ xmlSecCryptoDLLibraryCreate(const xmlChar* name) {
     }

 #ifdef XMLSEC_DL_LIBLTDL
+    lt_dlsetsearchpath("HOMEBREW_PREFIX/lib");
     lib->handle = lt_dlopenext((char*)lib->filename);
     if(lib->handle == NULL) {
         xmlSecError(XMLSEC_ERRORS_HERE,
