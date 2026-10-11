# PC Virtual real — Chromium + XFCE + noVNC

Ambiente **real** (não é simulação de UI):

- Linux (Ubuntu)
- Desktop **XFCE**
- Navegador **Chromium** real
- Acesso pelo browser via **noVNC** (porta 6080)
- Roda em **Docker**

## Requisitos

- Docker + Docker Compose
- PC/VPS com ~2 GB RAM (mínimo)

## Subir

```bash
git clone https://github.com/vibestreamoficial/pc_virtual_chromium.git
cd pc_virtual_chromium
docker compose up -d --build
```

Abra no navegador:

**http://localhost:6080**

(Senha VNC padrão: `pcvirtual` — troque em `docker-compose.yml`)

## O que tem dentro

| Item | Real? |
|------|--------|
| Sistema Linux | Sim |
| Desktop XFCE | Sim |
| Chromium | Sim (pacote oficial) |
| noVNC | Sim |
| Terminal | Sim |

## Comandos

```bash
# logs
docker compose logs -f

# parar
docker compose down

# reiniciar
docker compose restart
```

## Termux / Android

No celular o ideal é rodar isto numa **VPS** e abrir `http://IP:6080` no Chrome do Android.
Termux sozinho não substitui um container desktop completo com GPU/RAM de VPS.

## Segurança

- Troque `VNC_PASSWORD`
- Não exponha a porta 6080 na internet sem firewall/VPN
- Em produção use reverse proxy + HTTPS (Caddy/Nginx)

## Aviso

Uso legítimo: lab, testes, navegação isolada, desenvolvimento.
Responsabilidade de quem hospeda.
