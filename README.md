# Celestial-Uprising's Development Track &nbsp; [![bluebuild build badge](https://github.com/celestial-uprising/framework/actions/workflows/build.yml/badge.svg)](https://github.com/celestial-uprising/framework/actions/workflows/build.yml)

Celestial-Uprising brings the steadfast base of fedora atomic; tidied up, and finished with a blissfully-minimal niri environment.

We have incorporated:
- *Rhun* | gui Code-Editor, written in assembly resulting in astonishing speed and a slim footprint
- *Neovim* | cli Editor, with lazyvim and its dependencies preconfigured
- *Kitty* | terminal emulator, preconfigured for Celestial-Uprising and assigned to `CapsLock+Enter`
- *Herdr* | terminal multiplexor, assigned to `CapsLock+Shift+Enter`
- *Zen-Browser* | lightweight, appeasing design, compatible with firefox accounts
- *Kontainer* | gui distrobox manager, built from source with compiler optimizations and lto for lowest overhead
- *VMM* | access and manager virtual machines from any machine
- *Tailscale* | wireguard infused protocol, vpn, secure access, and psuedo-local networking
- *Plethora* of useful Rust and Golang tools to enable rapid systems development, management, and administration

## *Celestial-Uprising is proudly built for all, by lesbidoodles and their coven of magical rabbits*

## Spins

- *virt*  -- secure and specialized for qemu/kvm/libvirt virtual enviroments
- *headless / headless-nv*  -- server-oriented, deployable, and reliable
- *mini / mini-nv*  -- minimal & desktop-ready; no qemu/kvm/libvirtd/zfs
- *muse / muse-nv*  -- elegant workspace with creator tools preinstalled
- *dev / dev-nv*  -- clean & classy; qemu/kvm/libvirtd/zfs preinstalled
- *gg / gg-nv*  -- minimal desktop, maximum fps; steam/gamescope/mangohud
- *unholy / unholy-nv*  -- work hard, play hard, build anything

### Dog-fooding

Testing and development is performed on a small array of ryzen based machines with a variety of radeon and nvidia dgpus/igpus; by a coven of elusive rabbits with whom gaia has bestowed the privilege of magic

#### Personal Machines

| hostid | spin | cpu | memory | gpus |
| :--- | :--- | :--- | :--- | :--- |
|rhiannon |mini |AMD A4-9120C R4 2C+3G *2c/2t*|4GiB 1866MHz |Radeon iGPU |
|maebh |dev-nv |AMD Ryzen 7 5800H *8c/16t* |64GiB 3200MHz |Vega iGPU + RTX 3050ti Mobile dGPU *4GiB*|
|ada |headless-nv |AMD Ryzen 5 5600X *6c/12t* |64GiB 3200MHz |RX 580 *8GiB* + RTX 3070 *8GiB* |
|bella |headless |AMD Ryzen 7 5700G *8c/16t* |128GiB 3200MHz |Vega iGPU + Radeon Pro v340l *2x8GiB* |
|lily |virt |AMD EPYC Virtualized *6c/6t* |12GiB virtualized |--- |
|clara |mini | | | |

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
