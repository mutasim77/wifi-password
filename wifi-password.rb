class WifiPassword < Formula
  desc "Retrieve the password of the currently connected Wi-Fi network on macOS"
  homepage "https://github.com/mutasim77/wifi-password"
  url "https://github.com/mutasim77/wifi-password/archive/v1.0.0.tar.gz"
  sha256 "CHANGE_ME"
  license "MIT"

  def install
    bin.install "wifi-password.sh" => "wifi-password"
  end

  test do
    system "#{bin}/wifi-password", "--help"
  end
end
