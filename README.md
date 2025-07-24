# 📺 Pay-System

Sistema de gerenciamento de TV por assinatura, desenvolvido em **Ruby on Rails**, com funcionalidades completas para criação de **planos**, **pacotes**, **serviços adicionais**, **clientes**, **assinaturas** e geração automática de **contas**, **faturas** e **carnês**.

## 🚀 Funcionalidades

- Cadastro de **planos** com preços mensais.
- Cadastro de **serviços adicionais** (como HBO, Premiere, etc.).
- Criação de **pacotes** que combinam planos e serviços.
- Registro de **clientes** com dados pessoais.
- Criação de **assinaturas** com:
  - Validação de regras de negócio (plano OU pacote obrigatório, serviços adicionais não duplicados).
  - Geração automática de **12 contas mensais**, cada uma com uma **fatura**.
  - Geração de **carnê** com 12 faturas agrupadas.
- Tela de visualização de assinaturas, faturas e carnês (em desenvolvimento).

---

## ⚙️ Tecnologias

- Ruby 3.x
- Rails 8.x
- SQLite

---

## 📦 Uso

### Passos

```bash
# Clone o projeto
git clone https://github.com/fernandodxx/Pay-tv-system.git

# Instale as dependências
bundle install

# Configure o banco de dados
rails db:create db:migrate db:seed
