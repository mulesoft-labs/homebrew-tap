class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.7.3.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "596576ee575a813efc05b221ac84c94bc232c2bae344744446e92842f18aa100"

  #bottle do
  #  root_url "https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.7.1/"
  #  cellar :any_skip_relocation
  #  sha256 "fd4cfd58c7dce894e0f89fa6b60d926b71db69062f9cefead1f41ad3f5456cff" => :catalina
  #end

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
