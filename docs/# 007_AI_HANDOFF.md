# AI HANDOFF

## Purpose

This document is the primary entry point for any AI assistant (Lovable, Claude, ChatGPT, etc.) continuing development of the Faratech project.

Before making any changes:

1. Read this document.
2. Read `PROJECT_CONTEXT.md`.
3. Read the latest `SESSION_SUMMARY.md`.
4. Only then inspect the code relevant to the requested task.

Do not re-audit or redesign the project.

---

# Project

Faratech Medical Engineering Platform

Business:

* Medical equipment
* Wheelchairs
* Spare Parts
* Mobility Products

Goals:

* Professional engineering website
* SEO-first implementation
* Lead generation
* Multilingual support

---

# Current Phase

# Current Phase

Current Completed Phase:

✅ Phase 8 — Forms & Lead Generation

Current Active Phase:

➡️ Phase 9 — Internationalization Hardening

---

# Technology

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

Architecture

Route Loader

↓

Server Function

↓

Service

↓

Repository

↓

Database

---

# Current Status

Completed

* Product Model
* Category Structure
* Static Catalog
* Backend Foundation
* Database Schema
* Migrations
* Repository Layer
* DTO Layer
* Mapper Layer
* Service Layer
* Product Module
* Category Module
* Company Module
* Async Route Loaders
* Database-backed Product Pages
* Database-backed Category Pages
* Database-backed Company Profile

---

# Source of Truth

Runtime data must come from the database.

Static files should only remain as temporary migration sources until imported.

Persian content is canonical.

Localized fields use:

```ts
{
  fa: string;
  en?: string;
  ar?: string;
}
```

---

# Next Phase

Phase 5 — Data Import

Objectives:

* Import products
* Import company profile
* Import category content
* Validate imported records
* Remove remaining runtime dependency on static data

Do not implement new features during this phase.

---

# Future Roadmap

Phase 6

SEO Foundation

* Metadata
* JSON-LD
* Product Schema
* FAQ Schema
* Organization Schema

Phase 7

Media Integration

* Product Images
* Storage
* Documents
* Videos

Phase 8

Lead Generation

* Contact Forms
* Email Integration

Phase 9

QA

* Accessibility
* Performance
* Production Deployment

---

# Architectural Rules

Keep the existing architecture.

Do NOT redesign.

Do NOT introduce:

* CQRS
* Microservices
* Event Bus
* Kafka
* Authentication
* Dashboard
* Search Engine
* Analytics Platform

Repository Pattern is sufficient.

---

# Working Rules

Before implementing any feature:

* Read only the documentation relevant to the current phase.
* Prefer extending existing code over rewriting it.
* Preserve URLs and slugs.
* Preserve existing architecture.
* Keep implementation simple.

If the requested work falls outside the current phase, stop and explain why before making changes.
