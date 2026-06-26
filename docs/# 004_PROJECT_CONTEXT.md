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

Phase 9 — QA, Performance and Production Deployment

Objectives:

* End-to-end QA pass across locales
* Performance budgets and lighthouse audits
* Production deployment hardening

Completed Phases (latest first): Phase 8 — Forms & Lead Generation,
Phase 7 — Media Integration, Phase 6 — SEO Foundation, Phase 5 — Data
Import, Phase 4 — Data Wiring, Phase 3 — Backend Modules, Phase 2 —
Schema, Phase 1 — Product Model.

---

# Phase 8 Summary

Forms & Lead Generation completed:

* `public.leads` table with kind/status enums, length + email-format
  CHECK constraints, and RLS that allows anon/authenticated to INSERT
  only while service_role retains full access.
* Lead module under `src/lib/modules/leads/` follows the standard
  Repository → Service → Server Function pipeline (DTO, mapper,
  repository, service, server functions, email helper).
* `LeadRepository` generates the row id client-side and skips
  `RETURNING`, so the publishable-key client can insert without a
  SELECT policy.
* `lead-email.ts` posts to Resend when `RESEND_API_KEY` and
  `LEAD_NOTIFY_EMAIL` are set; otherwise logs server-side so capture
  never fails on notification errors.
* `src/lib/lead-capture.ts` keeps its `submitContact` /
  `submitNewsletter` surface and delegates to `submitContactLead` /
  `submitNewsletterLead` server functions, so the CTA UI is unchanged.
* `scripts/validate-phase8.ts` — 18/18 checks pass.

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
