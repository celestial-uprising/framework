# Celestial Uprising Framework &nbsp; [![bluebuild build badge](https://github.com/celestial-shepherd/celestial_shepherd/actions/workflows/build.yml/badge.svg)](https://github.com/celestial-shepherd/celestial_shepherd/actions/workflows/build.yml)

## Framework

Celestial Uprising's Framework brings the steadfast base of ucore:testing. Tidied up, and finished with a blissfully-minimal niri/fuzzel/waybar/kitty environment-- all configured OOTB for instant development.

### Celestial Uprising Framework is proudly built for all, by lesbidoodles and their coven of magical rabbits

## Roadmap for Framework

**Framework** has 12 versions, including nvidia variants:

- *virt*  -- secure container OS for cloud or local vm usage; specialized for qemu/kvm/libvirt virtual enviroments
- *headless / headless-nv*  --
- *mini / mini-nv*  --
- *touch*  --
- *dev / dev-nv*  --
- *gg / gg-nv*  --
- *unholy / unholy-nv*  --  workstation-ready OOTB, and full-featured (for a minimalist with work to do)
- *dev / dev-nv*  --  workstation-ready OOTB, and full-featured (for a minimalist with work to do)
- *dev / dev-nv*  --  workstation-ready OOTB, and full-featured (for a minimalist with work to do)
- *Framework-Mini*  --  hyperminimal, desktop-ready variant; without qemu/kvm, libvirtd, or their accompanying tools (virt-manager flatpak and virsh are still installed)
- *Framework-Headless*  --  server-oriented, deployable, and reliable- for headless enviroments (or anything without a monitor attached...)

### Dog-fooding
Testing and development is performed on a small array of ryzen based machines with a variety of radeon and nvidia dgpus/igpus; by a coven of elusive rabbits with whom gaia has bestowed the privilege of magic

## Installation

To rebase an existing **atomic**/**ucore**/**ublue** installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:

  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/celestial-uprising/${IMAGE_NAME}:latest
  ```

- Reboot to complete the rebase:

```
systemctl reboot
```

- Then rebase to the signed image, like so:

  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/celestial-uprising/${IMAGE_NAME}:latest
  ```

- Reboot again to complete the installation

  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top).

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/celestial-uprising/framework
```
