# FARATECH PROJECT CONTEXT

## Project

Faratech Medical Engineering Platform

Medical equipment company focused on:

* Wheelchairs
* Spare Parts
* Mobility Products

Primary goals:

* Professional engineering website
* SEO-first architecture
* Lead generation
* Multilingual (Persian source)

---

# Technology Stack

Frontend

* React 19
* TypeScript
* TanStack Start
* TanStack Router
* TailwindCSS 4
* shadcn/ui

Backend

* Supabase
* PostgreSQL
* Server Functions
* Repository Pattern

---

# Source of Truth

Database is the runtime source of truth.

Persian content is the canonical language.

Localized fields use:

```ts
{
  fa: string;
  en?: string;
  ar?: string;
}
```

English and Arabic will be AI-generated in a future phase.

---

# Architecture

The project follows a layered architecture:

Route Loader

↓

Server Function

↓

Service

↓

Repository

↓

Database

DTOs and Mappers separate transport models from persistence models.

UI components should never access the database directly.

---

# Current Project Status

## Phase 1

✅ Product Model

✅ Category Structure

✅ Product Repository Design

Completed.

---

## Phase 2

✅ Static Product Catalog

✅ Company Data

✅ Category Copy

Completed.

---

## Phase 3

Backend Foundation

Completed.

Implemented:

* Supabase
* PostgreSQL
* Database Schema
* Migrations
* Repository Layer
* Service Layer
* DTO Layer
* Mapper Layer
* Product Module
* Category Module
* Company Module
* Server Functions

No authentication.

No dashboard.

No analytics.

---

## Phase 4

Data Wiring

Completed.

Implemented:

* Async Route Loaders
* Product pages read from Server Functions
* Category pages read from Server Functions
* Company profile read from Server Functions
* Adapter layer preserving existing UI models
* Category slug compatibility layer
* Existing URLs preserved

Static editorial copy may remain temporarily until imported into the database.

---

# Current Runtime Flow

Database

↓

Repository

↓

Service

↓

Server Function

↓

Route Loader

↓

UI

---

# Next Planned Phase

Phase 8 — Forms & Lead Generation

Objectives:

* Contact form
* Lead capture pipeline
* Email integration

Completed Phases (latest first): Phase 7 — Media Integration, Phase 6 —
SEO Foundation, Phase 5 — Data Import, Phase 4 — Data Wiring, Phase 3
— Backend Modules, Phase 2 — Schema, Phase 1 — Product Model.

---

# Phase 7 Summary

Media Integration completed:

* `product-media` Supabase Storage bucket created (private; workspace
  policy blocks public buckets).
* `storage.objects` RLS scoped so only `service_role` may write.
* Public read served via `/api/public/media/$` proxy route that streams
  bucket objects with long-cache headers — no service credentials leak.
* `src/lib/media-url.ts` resolver normalizes the three accepted `src`
  shapes (absolute URL / site-rooted path / bucket key).
* Product mapper resolves `product_images.src`, `product_videos.src`,
  `product_videos.poster`, `product_documents.src`, and
  `product_seo.og_image` through the resolver.
* Product route head emits `og:image` and `twitter:image` from
  `product_seo.og_image` with a fallback to the primary image when
  present.
* `scripts/validate-phase7.ts` verifies all media invariants.

---

# Future Phases

Phase 6

SEO Foundation

* Metadata
* JSON-LD
* Product Schema
* Organization Schema
* FAQ Schema

Phase 7

Media Integration

* Product Images
* Documents
* Videos
* Storage

Phase 8

Forms & Lead Generation

Phase 9

QA, Performance and Production Deployment

---

# Architectural Constraints

Do NOT introduce:

* Microservices
* CQRS
* Event Bus
* Kafka
* Authentication
* Dashboard
* Search Engine
* Analytics System

Prefer simple repository-based architecture.
