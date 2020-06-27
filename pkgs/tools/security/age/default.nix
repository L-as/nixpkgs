{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "age";
  version = "unstable-2020-05-19";
  goPackagePath = "github.com/FiloSottile/age";
  vendorSha256 = "0km7a2826j3fk2nrkmgc990chrkcfz006wfw14yilsa4p2hmfl7m";

  subPackages = [
    "cmd/age"
    "cmd/age-keygen"
  ];

  src = fetchFromGitHub {
    owner = "FiloSottile";
    repo = "age";
    rev = "c9a35c072716b5ac6cd815366999c9e189b0c317";
    sha256 = "0mb50g38rc2pww7iqwrgwr9gwhm7y86xpz8mf7y9wpra0315jk8m";
  };

  meta = with lib; {
    homepage = "https://age-encryption.org/";
    description = "Modern encryption tool with small explicit keys";
    license = licenses.bsd3;
    maintainers = with maintainers; [ tazjin ];
  };
}
