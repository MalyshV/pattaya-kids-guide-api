# 🧭 Pattaya Kids Guide API

Backend for a Live Guide for Parents in Pattaya.  
Core concept: Events + Places + Personalization (NOT just a static catalog).

---

## 🚀 Tech Stack

- Node.js + TypeScript
- Prisma 7
- PostgreSQL (Neon)
- @prisma/adapter-pg (required for Neon pooled connection)
- tsx (seed runner)

---

## 🧠 Product Concept (Important)

This project is NOT just a places catalog.

It is a live event-driven guide for parents:

- Events (temporary content)
- Places (permanent locations)
- Future: personalization (favorites, visited, preferences)
- Community + UGC (planned)

Key architectural rule:
Event can exist WITHOUT a Place (pop-ups, festivals, hotel events, etc.).

---

## 📦 Installation

Install dependencies:
npm install

Generate Prisma Client:
npx prisma generate

---

## ⚙️ Environment Variables

Create a `.env` file in the project root:

DATABASE_URL=your_neon_postgres_connection_string

Important:

- Do NOT commit `.env`
- `.env` must be in `.gitignore`
- Do NOT wrap DATABASE_URL in quotes

Correct:
DATABASE_URL=postgresql://user:password@host/db

Incorrect:
DATABASE_URL="postgresql://user:password@host/db"

---

## 🗄 Database (Prisma 7 + Neon)

This project uses:

- Prisma 7 config mode (prisma.config.ts)
- Neon pooled PostgreSQL
- Adapter-based Prisma Client (NOT default client)

Because Neon uses a pooler, seed and scripts MUST use:
@prisma/adapter-pg

Using `new PrismaClient()` without adapter will cause:
PrismaClientInitializationError

---

## 🌱 Seed (Very Important)

Run seed:
npx prisma db seed

Seed is:

- Idempotent (safe to run multiple times)
- Uses upsert instead of create
- Will NOT create duplicates
- Compatible with Prisma 7 + Neon adapter

Seed creates:

- Event categories
- 3 DEMO events:
  - Upcoming
  - Ongoing
  - Past (archive testing)

---

## 🎭 Demo Events Policy

Demo events are intentionally included for:

- UI development
- API testing
- lifecycle logic (upcoming / ongoing / past)
- filtering and sorting tests

All demo events are marked with:
[DEMO] in title

Slug is NEVER changed (used as upsert anchor).

---

## 🔍 Prisma Studio (Database UI)

Open database GUI:
npx prisma studio

Use it to verify:

- EventCategory table
- Event table (DEMO events)
- No duplicates after multiple seed runs

---

## 🧩 Event Lifecycle Logic (Core Feature)

Event lifecycle:

- Upcoming → startDate > now
- Ongoing → startDate <= now <= endDate
- Past → endDate < now (archive, NOT deleted)

Important:
Past events are NOT removed from the database.
This preserves history, SEO value, and user trust.

---

## 📁 Key Project Files

prisma/
schema.prisma
seed.ts
prisma.config.ts

Notes:

- prisma.config.ts manages datasource (Prisma 7 mode)
- seed.ts uses Neon adapter (critical)
- schema.prisma intentionally has no datasource URL

---

## ⚠️ Critical Development Notes

Do NOT:

- Add `url` to schema.prisma (Prisma 7 config mode)
- Remove adapter from seed.ts
- Replace upsert with create in seed
- Commit `.env` file

If seed crashes:

1. Check adapter in seed.ts
2. Check DATABASE_URL format (no quotes)
3. Run:
   npx prisma generate
   npx prisma db seed

---

## 📌 Current Status (Milestone)

Stable:

- Prisma 7 + Neon connection
- Adapter-based seed
- Idempotent demo data
- Event lifecycle-ready database

Tag: v0.1-seed-stable
