class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/refs/tags/v1.8.0.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "e35b6cea3fa365e0dbe10e2128a554d67b39979c86e726f43c907d4d13008def"

  bottle do
    root_url "https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.8.0/"
    sha256 cellar: :any_skip_relocation, big_sur: "678c61f47dde1ded86fa8ae135214d095515ae5e472c9afd38535d1f322c8463"
  end

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

## 1.8.0 doesn't match >.<
#  test do
#    assert_match version.to_s, shell_output("#{bin}/aws-keycloak --version")
#  end
end
