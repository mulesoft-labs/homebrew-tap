#require "language/go"

class AwsKeycloak < Formula
  desc "aws-vault like tool for Keycloak authentication"
  homepage "https://github.com/mulesoft-labs/aws-keycloak"
  url "https://github.com/mulesoft-labs/aws-keycloak/archive/v1.3.6.tar.gz"
  # curl -L $url | shasum -a256
  sha256 "479ff10396627ea152aedbd90e1c510a4d7169eca56393be57a4a3167951f625"

  #bottle do
  #  root_url "https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.3.6/"
  #  cellar :any_skip_relocation
  #  sha256 "6f3b3600604bb1dfdff16663616ef33d7be598f4ab95e5ee040d35dc3b1a1ba5" => :high_sierra
  #end

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    dir = buildpath/"src/github.com/mulesoft-labs/aws-keycloak"
    dir.install buildpath.children
    #Language::Go.stage_deps resources, buildpath/"src"
    cd dir do
      system "make", "dep"
      system "make"
      #prefix.install_metadata
      bin.install "aws-keycloak"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aws-keycloak --version")
  end
end
