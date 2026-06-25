import { createFileRoute, Outlet, notFound } from "@tanstack/react-router";
import { useEffect } from "react";
import { Navigation } from "@/components/faratech/navigation";
import { Footer } from "@/components/faratech/footer";
import { isLang, dirOf, type Lang } from "@/lib/i18n";
import { getCompanyProfile } from "@/lib/modules/company/company.functions";

export const Route = createFileRoute("/$lang")({
  beforeLoad: ({ params }) => { if (!isLang(params.lang)) throw notFound(); },
  // Phase 4: company profile is fetched through the existing server fn so
  // the database is the runtime source of truth. Returns null until the
  // company_profile row is seeded (Phase 5); UI falls back gracefully.
  loader: async () => {
    try {
      const company = await getCompanyProfile();
      return { company };
    } catch (err) {
      console.error("[company] failed to load profile", err);
      return { company: null };
    }
  },
  errorComponent: ({ error }) => (
    <div className="max-w-2xl mx-auto p-8 text-sm text-red-600">
      {error.message}
    </div>
  ),
  notFoundComponent: () => <div className="p-8">Not found.</div>,
  component: LangLayout,
});

function LangLayout() {
  const { lang } = Route.useParams();
  const l = lang as Lang;
  useEffect(() => {
    const html = document.documentElement;
    html.lang = l;
    html.dir = dirOf(l);
    return () => { html.dir = "ltr"; };
  }, [l]);
  return (
    <div className="min-h-screen flex flex-col">
      <Navigation lang={l} />
      <main className="flex-1"><Outlet /></main>
      <Footer lang={l} />
    </div>
  );
}
