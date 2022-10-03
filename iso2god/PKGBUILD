# Maintainer: Ilia Pozdnyakov <ilia.pozdnyakov@ya.ru>
pkgname="iso2god"
pkgver="1.4.3"
pkgrel="2"
pkgdesc="A tool to convert between Xbox 360 ISO and Games On Demand file formats"
arch=("x86_64")
url="https://github.com/iliazeus/iso2god-rs"
license=("MIT")
depends=()
makedepends=()
conflicts=("iso2god-cli")
source=("$pkgname-$pkgver"::"https://github.com/iliazeus/iso2god-rs/releases/download/v$pkgver/iso2god")
md5sums=("9aac8a6ce3de074dc69020b091a6b24b")

package() {
  install -Dm0755 "$pkgname-$pkgver" "$pkgdir/usr/bin/iso2god"
}
