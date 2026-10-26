sudo dnf groupinstall "Development Tools"
git clone https://github.com/YaLTeR/niri.git
cd niri
cargo build --release
sudo cp target/release/niri /usr/local/bin/
sudo cp resources/niri.desktop /usr/share/wayland-sessions/
sudo cp resources/niri-session /usr/local/bin/
mkdir -p ~/.config/niri
cp /usr/share/doc/niri/default-config.kdl ~/.config/niri/config.kdl
# If built from source, copy it from your cloned folder:
# cp resources/default-config.kdl ~/.config/niri/config.kdl
cargo install --locked xwayland-satellite
sudo cp ~/.cargo/bin/xwayland-satellite /usr/local/bin/

