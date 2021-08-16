class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.7.5.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "814fd8d90d13565612212ee6f5c5223d8d9bd4e140e12acf11a50c3a14a92f82"

  bottle do
    root_url "https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.7.5/"
    sha256 cellar: :any_skip_relocation, big_sur: "faef1c8637624dd0034caf9c4cad0e17b69be121c1a6f18b929972f86e00236d"
  end

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    dir = buildpath/"src/github.com/mulesoft-labs/aws-keycloak"
    dir.install buildpath.children
    cd dir do
      system "make"
      bin.install "aws-keycloak"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aws-keycloak --version")
  end
end
