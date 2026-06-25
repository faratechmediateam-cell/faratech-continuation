import { createFileRoute } from "@tanstack/react-router";
import { Hero } from "@/components/faratech/hero";
import { HeroShortcuts } from "@/components/faratech/hero-shortcuts";
import { Stats } from "@/components/faratech/stats";
import { ProductsSection } from "@/components/faratech/products-section";
import { Engineering } from "@/components/faratech/engineering";
import { Solutions } from "@/components/faratech/solutions";
import { Testimonials } from "@/components/faratech/testimonials";
import { CTA } from "@/components/faratech/cta";
import type { Lang } from "@/lib/i18n";
import { buildLocaleMeta } from "@/lib/seo";

export const Route = createFileRoute("/$lang/")({
  head: ({ params }) => {
    const lang = (params?.lang as Lang) ?? "fa";
    const locale = buildLocaleMeta(lang, (l) => `/${l}`);
    return {
      meta: [
        { title: "FARATECH — Engineering Mobility Excellence" },
        { name: "description", content: "Premium wheelchair systems trusted by hospitals and rehabilitation centers worldwide." },
        ...locale.meta,
      ],
      links: [
        { rel: "preload", as: "image", href: "/wheelchair-hero.png", fetchpriority: "high" },
        ...locale.links,
      ],
    };
  },
  component: Home,
});

function Home() {
  const { lang } = Route.useParams();
  const l = lang as Lang;
  return (
    <>
      <Hero lang={l} />
      <HeroShortcuts lang={l} />
      <Stats lang={l} />
      <ProductsSection lang={l} />
      <Engineering lang={l} />
      <Solutions lang={l} />
      <Testimonials lang={l} />
      <CTA lang={l} />
    </>
  );
}
