// SEO helpers — canonical/og:url/hreflang and structured-data builders.
// Site URL is intentionally relative until a custom domain is configured.

import { LANGS, type Lang } from "./i18n";
import { COMPANY_PROFILE, phoneToE164 } from "./data/company";

// Use relative URLs so crawlers resolve against whichever host serves the page.
// Once a custom domain is configured, set this to an absolute origin.
export const SITE_ORIGIN = "";

export const absUrl = (path: string) => `${SITE_ORIGIN}${path}`;

/**
 * Build per-route head entries: canonical link + og:url + hreflang alternates
 * for every supported language plus an x-default that points to the FA route
 * (since `/` redirects to `/fa`).
 *
 * `pathBuilder(lang)` returns the path for a given language (e.g.
 * `(l) => `/${l}/products/${slug}`).
 */
export function buildLocaleMeta(currentLang: Lang, pathBuilder: (l: Lang) => string) {
  const selfPath = pathBuilder(currentLang);
  const alternates = LANGS.map((l) => ({
    rel: "alternate" as const,
    hrefLang: l,
    href: absUrl(pathBuilder(l)),
  }));
  return {
    links: [
      { rel: "canonical", href: absUrl(selfPath) },
      ...alternates,
      { rel: "alternate", hrefLang: "x-default", href: absUrl(pathBuilder("fa")) },
    ],
    meta: [
      { property: "og:url", content: absUrl(selfPath) },
      { property: "og:locale", content: currentLang === "en" ? "en_US" : currentLang === "fa" ? "fa_IR" : "ar_SA" },
    ],
  };
}

export const organizationJsonLd = () =>
  JSON.stringify({
    "@context": "https://schema.org",
    "@type": "Organization",
    name: "FARATECH",
    legalName: COMPANY_PROFILE.nameEn,
    alternateName: COMPANY_PROFILE.nameFa,
    url: SITE_ORIGIN || "/",
    logo: absUrl("/logo.png"),
    sameAs: COMPANY_PROFILE.contact.websites.map((w) => `https://${w}`),
    address: {
      "@type": "PostalAddress",
      streetAddress: COMPANY_PROFILE.contact.headOfficeAddress,
      addressCountry: "IR",
    },
    contactPoint: COMPANY_PROFILE.contact.phoneNumbers.map((p) => ({
      "@type": "ContactPoint",
      telephone: phoneToE164(p),
      contactType: "sales",
      areaServed: ["IR", "EU", "ME"],
      availableLanguage: ["en", "fa", "ar"],
    })),
  });


export const breadcrumbJsonLd = (items: { name: string; path: string }[]) =>
  JSON.stringify({
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: items.map((it, i) => ({
      "@type": "ListItem",
      position: i + 1,
      name: it.name,
      item: absUrl(it.path),
    })),
  });

export const productJsonLd = (params: {
  name: string;
  description: string;
  image?: string;
  category: string;
  brand?: string;
  sku?: string;
}) =>
  JSON.stringify({
    "@context": "https://schema.org",
    "@type": "Product",
    name: params.name,
    description: params.description,
    image: params.image ? absUrl(params.image) : undefined,
    category: params.category,
    brand: { "@type": "Brand", name: params.brand ?? "FARATECH" },
    sku: params.sku,
    manufacturer: { "@type": "Organization", name: "FARATECH" },
  });
