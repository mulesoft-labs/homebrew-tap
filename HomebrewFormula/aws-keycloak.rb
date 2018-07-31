require "language/go"

class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.3.4.tar.gz"
  sha256 "66d68250181f2ccc1aafc86ce31d926e2ed0713a4e8496c938dc98982dd6b2f4"

  depends_on "go" => :build
  depends_on "dep" => :build

  def install
    ENV["GOPATH"] = buildpath

    dir = buildpath/"src/github.com/mulesoft-labs/aws-keycloak"
    dir.install buildpath.children
    Language::Go.stage_deps resources, buildpath/"src"
    cd dir do
      system "make", "dep"
      system "make"
      #prefix.install_metadata
      bin.install "aws-keycloak"
    end
  end

  test do
    assert_match version.to_s, shell_output("aws-keycloak --version")
  end
end
