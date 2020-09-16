class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.7.1.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "f4a24879573b5740101090a9252d0bc1083d11007219a3bcae93fde500168f8c"

  bottle do
    root_url "https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.7.1/"
    cellar :any_skip_relocation
    sha256 "fd4cfd58c7dce894e0f89fa6b60d926b71db69062f9cefead1f41ad3f5456cff" => :catalina
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
