class YtDlp < Formula
  include Language::Python::Virtualenv

  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"
  url "https://files.pythonhosted.org/packages/1b/b0/fa65235daddb197109fbd2fabecd9587ae37a598d966464c873b1f281dd3/yt_dlp-2024.7.8.tar.gz"
  sha256 "9367e9b2e8dac4b37f512d21a4533273de22009dd74588ad24a7528c7f77b806"
  license "Unlicense"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2ef0da1bcba6194517b569aff9b540468e5ef2c4f2f490afbb98cdab7e79cb73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8cf4f3b923153d218719e60660f576eed5d21dd54e6579a812bca30ff90b1d94"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4c90d3e12c0c663bc55601363baaa95f707e09b4b1c1a79da4fc459c6d029a08"
    sha256 cellar: :any_skip_relocation, sonoma:         "859eedc9f79ba38e70d0c5c2fe0b7f48454bbcbd3d92e27150ff0cce588b52c9"
    sha256 cellar: :any_skip_relocation, ventura:        "da9d25fccc318b2ac36f1f101e15f7b322fd0adbd33437a7bdf4c115e97e99b9"
    sha256 cellar: :any_skip_relocation, monterey:       "6f92943c321aa37f0a6d362672e77b63ba096d481a9aacf29fc353faae6ba298"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "68cdd9c724929d631c28cceed4a9330f069dfa696acbbff18cbcc4605d03dcfb"
  end

  head do
    url "https://github.com/yt-dlp/yt-dlp.git", branch: "master"

    depends_on "pandoc" => :build

    on_macos do
      depends_on "make" => :build
    end
  end

  depends_on "certifi"
  depends_on "python@3.12"

  resource "brotli" do
    url "https://files.pythonhosted.org/packages/2f/c2/f9e977608bdf958650638c3f1e28f85a1b075f075ebbe77db8555463787b/Brotli-1.1.0.tar.gz"
    sha256 "81de08ac11bcb85841e440c13611c00b67d3bf82698314928d0b676362546724"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f30c3cb33b24454a82faecaf01b19c18562b1e89558fb6c56de4d9118a032fd5"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/21/ed/f86a79a07470cb07819390452f178b3bef1d375f2ec021ecfc709fc7cf07/idna-3.7.tar.gz"
    sha256 "028ff3aadf0609c1fd278d8ea3089299412a7a8b9bd005dd08b9f8285bcb5cfc"
  end

  resource "mutagen" do
    url "https://files.pythonhosted.org/packages/81/e6/64bc71b74eef4b68e61eb921dcf72dabd9e4ec4af1e11891bbd312ccbb77/mutagen-1.47.0.tar.gz"
    sha256 "719fadef0a978c31b4cf3c956261b3c58b6948b32023078a2117b1de09f0fc99"
  end

  resource "pycryptodomex" do
    url "https://files.pythonhosted.org/packages/31/a4/b03a16637574312c1b54c55aedeed8a4cb7d101d44058d46a0e5706c63e1/pycryptodomex-3.20.0.tar.gz"
    sha256 "7a710b79baddd65b806402e14766c721aee8fb83381769c27920f26476276c1e"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/43/6d/fa469ae21497ddc8bc93e5877702dca7cb8f911e337aca7452b5724f1bb6/urllib3-2.2.2.tar.gz"
    sha256 "dd505485549a7a552833da5e6063639d0d177c04f23bc3864e41e5dc5f612168"
  end

  resource "websockets" do
    url "https://files.pythonhosted.org/packages/2e/62/7a7874b7285413c954a4cca3c11fd851f11b2fe5b4ae2d9bee4f6d9bdb10/websockets-12.0.tar.gz"
    sha256 "81df9cbcbb6c260de1e007e58c011bfebe2dafc8435107b0537f393dd38c8b1b"
  end

  def install
    system "gmake", "lazy-extractors", "pypi-files" if build.head?
    virtualenv_install_with_resources
    man1.install_symlink libexec/"share/man/man1/yt-dlp.1"
    bash_completion.install libexec/"share/bash-completion/completions/yt-dlp"
    zsh_completion.install libexec/"share/zsh/site-functions/_yt-dlp"
    fish_completion.install libexec/"share/fish/vendor_completions.d/yt-dlp.fish"
  end

  test do
    system "#{bin}/yt-dlp", "--simulate", "https://www.youtube.com/watch?v=pOtd1cbOP7k"
    system "#{bin}/yt-dlp", "--simulate", "--yes-playlist", "https://www.youtube.com/watch?v=pOtd1cbOP7k&list=PLMsZ739TZDoLj9u_nob8jBKSC-mZb0Nhj"
  end
end
