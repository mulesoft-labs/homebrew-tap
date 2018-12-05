class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.4.0.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "b62bd85c6a87c30fd7d38e1a6296fbef126ab8bb9dbc31e350613cc39043a68c"

  bottle do
    root_url "https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.4.0/"
    cellar :any_skip_relocation
    sha256 "1c8e57babdbcaa71d2ad1591234945407e814043d35ff98193e22d3fc09f1ac2" => :high_sierra
  end

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
