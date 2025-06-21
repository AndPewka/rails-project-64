<div align="center">

![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red)
![Rails](https://img.shields.io/badge/Rails-8.0.2-brightgreen)
[![CI](https://github.com/AndPewka/rails-project-64/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/AndPewka/rails-project-64/actions)

# HexletCode Blog

</div>

> **HexletCode Blog** — учебное Rails-приложение, созданное в рамках курса  
> «Ruby on Rails разработчик» от **Hexlet**.  
> Демонстрирует базовые возможности Rails 8 (Hotwire/Turbo, Devise, Propshaft, css/js-bundling),
> приёмы организации кода и CI/CD на GitHub Actions + Render.

## 🚀 Демо-сайт
<https://rails-project-64-pmc8.onrender.com>

---

## ✨ Возможности

* CRUD-посты с комментариями  
* Аутентификация Devise  
* Древовидные комментарии (gem **ancestry**)  
* Лайки к постам и комментариям  
* Bootstrap 5 + Stimulus для динамики  
* CI: линтеры, тесты и автоматический деплой на Render

## 🛠 Технологический стек

| Layer            | Выбор                                              |
|------------------|----------------------------------------------------|
| Backend          | **Ruby 3.2.2**, **Rails 8.0.2**                    |
| DB (production)  | PostgreSQL (Render PostgreSQL free)                |
| DB (dev/test)    | SQLite 3                                           |
| Frontend assets  | Propshaft + cssbundling-rails (PostCSS)            |
| JS-bundling      | esbuild via jsbundling-rails                       |
| Auth             | Devise                                             |
| CI/CD            | GitHub Actions → Render deploy                     |

---

## ⚡ Быстрый старт локально

> Требования: **Ruby 3.2+, Node ≥ 18, Yarn / npm, SQLite ≥ 3.8**

```bash
# 1. Клонируем
git clone https://github.com/AndPewka/rails-project-64.git
cd rails-project-64

# 2. Устанавливаем гемы и JS-зависимости
bundle install
yarn install --frozen-lockfile

# 3. Подготавливаем БД и ассеты
bundle exec rails db:setup
bundle exec rails assets:precompile

# 4. Запускаем сервер
bundle exec rails s

# → приложение доступно на http://localhost:3000
