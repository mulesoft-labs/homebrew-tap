class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.7.0.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "6e09cd6a7ee887d2cc4947e2de37bef5e50beda170b76909ad89456f67ca8654"

  bottle do
    root_url "https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.7.0/"
    cellar :any_skip_relocation
    sha256 "c24fd6d6aab16a18947b91c47883e39e8cfda9f07be233409de2267c514bec9b" => :catalina
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
