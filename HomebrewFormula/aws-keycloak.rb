class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.4.1.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "f404931b01fc3eb292212b7c21b8f1ceddcf2d8462e6fad310c62548d270b98a"

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    dir = buildpath/"src/github.com/mulesoft-labs/aws-keycloak"
    dir.install buildpath.children
    cd dir do
      system "make", "dep"
      system "make"
      bin.install "aws-keycloak"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aws-keycloak --version")
  end
end
