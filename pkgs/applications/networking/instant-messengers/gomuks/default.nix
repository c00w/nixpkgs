{ stdenv, buildGoModule, fetchFromGitHub, makeDesktopItem }:

buildGoModule rec {
  pname = "gomuks";
  version = "2020-03-20";

  src = fetchFromGitHub {
    owner = "tulir";
    repo = pname;
    rev = "bce30e32a049b3ee76081c8d3881a3820b0e7341";
    sha256 = "0f7i88vrvl1xl4hmjplq3wwihqwijbgxy6nk5fkvc8pfmm5hsjcs";
  };

  vendorSha256 = "0paaqiycgp8xg5kz4inqvxxgqjrn8i6qj2yh6yw377l7h6frf4yc";
  regenGoMod = true;

  postInstall = ''
    cp -r ${
      makeDesktopItem {
        name = "net.maunium.gomuks.desktop";
        exec = "@out@/bin/gomuks";
        terminal = "true";
        desktopName = "Gomuks";
        genericName = "Matrix client";
        categories = "Network;Chat";
        comment = meta.description;
      }
    }/* $out/
    substituteAllInPlace $out/share/applications/*
  '';

  meta = with stdenv.lib; {
    homepage = "https://maunium.net/go/gomuks/";
    description = "A terminal based Matrix client written in Go";
    license = licenses.gpl3;
    maintainers = with maintainers; [ tilpner emily ];
    platforms = platforms.unix;
  };
}
