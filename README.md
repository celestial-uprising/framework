# Celestial Uprising Framework &nbsp; [![bluebuild build badge](https://github.com/celestial-shepherd/celestial_shepherd/actions/workflows/build.yml/badge.svg)](https://github.com/celestial-shepherd/celestial_shepherd/actions/workflows/build.yml)

## Framework

Celestial Uprising's Framework brings the steadfast base of ucore:testing. Tidied up, and finished with a blissfully-minimal niri/fuzzel/waybar/kitty environment-- all configured OOTB for instant development.

### Celestial Uprising Framework is proudly built for all, by lesbidoodles and their coven of magical rabbits

## Roadmap for Framework

**Framework** has 12 versions, including nvidia variants:

- *virt*  -- secure and specialized for qemu/kvm/libvirt virtual enviroments
- *headless / headless-nv*  -- server-oriented, deployable, and reliable
- *mini / mini-nv*  -- minimal & desktop-ready; no qemu/kvm/libvirtd/zfs 
- *muse / muse-nv*  -- elegant workspace with creator tools preinstalled 
- *dev / dev-nv*  -- clean & classy; qemu/kvm/libvirtd/zfs preinstalled
- *gg / gg-nv*  -- minimal desktop, maximum fps; steam/gamescope/mangohud
- *unholy / unholy-nv*  -- work hard, play hard, build anything

### Dog-fooding

Testing and development is performed on a small array of ryzen based machines with a variety of radeon and nvidia dgpus/igpus; by a coven of elusive rabbits with whom gaia has bestowed the privilege of magic

## Installation

To rebase an existing **atomic**/**ucore**/**ublue** installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:

  ```bash
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/celestial-uprising/${IMAGE_NAME}:latest
  ```

- Reboot to complete the rebase:

  ```bash
  sudo systemctl reboot
  ```

- Then rebase to the signed image, like so:

  ```bash
  sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/celestial-uprising/${IMAGE_NAME}:latest
  ```

- Reboot again to complete the installation

  ```bash
  sudo systemctl reboot
  ```

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top).

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/celestial-uprising/framework
```
