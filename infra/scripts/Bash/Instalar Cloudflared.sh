# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg | sudo tee /usr/share/keyrings/cloudflare-public-v2.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
sudo apt-get update && sudo apt-get install cloudflared


# una vez instalado inicio automatico

sudo cloudflared service install eyJhIjoiOGQ1NWNjMDZkNmI5OWQzNTQ1M2UyZjhhYzYyNzE4OGMiLCJ0IjoiZTY3N2JmMGEtYzVkMy00M2Y0LTkwNWItY2IyODA2NzE3NjI4IiwicyI6Ik1qaGpZekUxTTJVdFpHSmhZeTAwTXpRekxXSTJaakF0WldaaE1qVXpOamxtTUdNeCJ9

# una vez instalado inicio manual

cloudflared tunnel run --token eyJhIjoiOGQ1NWNjMDZkNmI5OWQzNTQ1M2UyZjhhYzYyNzE4OGMiLCJ0IjoiZTY3N2JmMGEtYzVkMy00M2Y0LTkwNWItY2IyODA2NzE3NjI4IiwicyI6Ik1qaGpZekUxTTJVdFpHSmhZeTAwTXpRekxXSTJaakF0WldaaE1qVXpOamxtTUdNeCJ9