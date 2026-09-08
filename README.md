# Celestial Uprising Framework &nbsp; [![bluebuild build badge](https://github.com/celestial-shepherd/celestial_shepherd/actions/workflows/build.yml/badge.svg)](https://github.com/celestial-shepherd/celestial_shepherd/actions/workflows/build.yml)

## Framework

Celestial Uprising Framework features a ublue-hci base, with several small reductions. Then, built into the immutable image itself: minimal, preconfigured niri desktop with a clean and useful defaults, matching waybar fuzzel, and opinionated-yet-minimal kitty. Modern tools (eza, ripgrep, btop, etc) are included out-of-the-box, as well as rustup for maintaining the latest toolchain, and neovim (as well as its dependencies, and those of lazyvim, and even vim itself).

### Celestial Uprising Framework is proudly built for everyone, by lesbidoodles and their coven of magical rabbits

## Roadmap for Framework

**CF** will have three planned 'sub-versions' (as well as nvidia variants for each)

- [Celestial Framework Mini] hyperminimal, desktop-ready variant; without qemu/kvm, libvirtd, or their accompanying tools (virt-manager flatpak and virsh are still installed)
- [Celestial Framework] workstation-ready OOTB, and full-featured (for a minimalist with work to do)
- [Celestial Framework Headless] server-oriented, deployable, and reliable- for headless enviroments (or anything without a monitor attached...)

### Testing and development is performed on a small array of ryzen based machines with a variety of radeon and nvidia dgpus/igpus; by a coven of elusive rabbits with whom gaia has bestowed the privilege of magic

#### Dog-fooding

## Installation

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:

  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/celestial-uprising/cfw:latest
  ```

- Reboot to complete the rebase:

=======

```
systemctl reboot
```

- Then rebase to the signed image, like so:

  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/celestial-uprising/cfw:latest
  ```

- Reboot again to complete the installation

  ```
  systemctl reboot
  ```

- Then rebase to the signed image, like so:

  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/celestial-uprising/cfw:latest
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
cosign verify --key cosign.pub ghcr.io/celestial-uprising/cfw
```
