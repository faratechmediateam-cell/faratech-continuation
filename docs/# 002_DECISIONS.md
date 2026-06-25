# DECISIONS.md

# Faratech Architecture Decisions

Last Updated: YYYY-MM-DD

---

# Business Positioning

Faratech is an engineering and medical technology company.

The website must prioritize:

* Engineering
* Reliability
* Innovation
* Trust

The website must NOT feel like an aggressive marketing website.

---

# Technical Stack

Frontend

* React 19
* TypeScript
* TanStack Router
* TailwindCSS 4

Backend

* NestJS

Database

* PostgreSQL

ORM

* Prisma

Caching

* Redis

Storage

* S3 Compatible Storage

Analytics

* PostHog

Search

* Meilisearch

---

# Architecture Decisions

Feature Based Architecture is mandatory.

Structure:

src/
modules/
shared/
services/
ui/
hooks/
types/

Business Logic must never be inside UI components.

---

# Performance Targets

LCP < 2s

CLS < 0.05

INP < 150ms

---

# Design Direction

Inspired by:

* Permobil
* Sunrise Medical
* Ottobock
* Invacare

Design Style:

* Premium
* Engineering Focused
* Medical Technology
* Minimal

Avoid:

* Salesy Design
* Excessive Animation
* Marketing Hype

---

# Product Strategy

Products are engineering solutions.

Products are NOT advertisements.

Every product page must contain:

* Technical Specifications
* Downloads
* Related Products
* FAQ
* SEO Metadata

---

# Dashboard Strategy

Dashboard is the highest priority feature.

Dashboard must include:

* User Analytics
* Product Analytics
* Article Analytics
* Conversion Analytics
* Audit Logs
* Session Analytics

Dashboard architecture must be completed before implementation.

---

# Content Strategy

Articles are a core SEO asset.

Content Clusters:

* Electric Wheelchairs
* Wheelchairs
* Patient Lifts
* Mobility Scooters
* Rehabilitation Equipment

---

# Authentication

Required:

* Google Login
* Email Login
* Phone OTP

Roles:

* Super Admin
* Admin
* Editor
* Sales
* Dealer
* Customer

---

# SEO Decisions

SEO must be implemented after:

* Product CMS
* Article CMS

No SEO shortcuts allowed.

No AI spam.

No keyword stuffing.

---

# Development Rules

No file above 500 lines.

No component above 300 lines.

No duplicated business logic.

No breaking architectural decisions without approval.

Always create migration plans before large refactors.

---

# Context Efficiency Rules

When implementing a feature:

- Analyze only related modules.
- Avoid full-project re-analysis.
- Re-audit the entire repository only when explicitly requested.
- Prefer incremental changes over large rewrites.
- Use PROJECT_CONTEXT.md as the primary source for recent project state.
- Use DECISIONS.md as the source of truth for architectural decisions.

---

# AI Collaboration Model

Claude responsibilities:

- Architecture
- Technical Design
- Specifications
- Audits
- Reviews
- Risk Analysis

Lovable responsibilities:

- Implementation
- Refactoring
- UI Development
- Feature Delivery

Claude generates specifications.

Lovable implements specifications.

Claude reviews implementation results.

Implementation must not bypass architecture decisions.


---

# Completed Phases

(To be updated)

---

# Pending Phases

(To be updated)

---

# Known Issues

(To be updated)
