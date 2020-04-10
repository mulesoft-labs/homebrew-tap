class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.5.0.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "420ece5c0fffe2c6e9b1c6a261fd438e2b20d1c4e727253944de8a56f67a48f7"

  #bottle do
    #root_url "https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.4.1/"
    #cellar :any_skip_relocation
    #sha256 "5fec0e5c8ec47c81bb957244b98794b47d79ddd966c0afad9a235c3fb9c0c1e8" => :mojave
  #end

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
