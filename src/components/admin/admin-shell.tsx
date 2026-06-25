import { Link, useRouterState } from "@tanstack/react-router";
import type { ReactNode } from "react";
import { Database, FileText, Image as ImageIcon, Settings } from "lucide-react";

import { cn } from "@/lib/utils";

type NavItem = {
  label: string;
  to?: string;
  icon: typeof Database;
  badge?: string;
  disabled?: boolean;
};

const NAV: NavItem[] = [
  { label: "Products", to: "/admin/products", icon: Database },
  { label: "Articles", icon: FileText, badge: "Phase 1B", disabled: true },
  { label: "Media", icon: ImageIcon, badge: "Later", disabled: true },
  { label: "Settings", icon: Settings, disabled: true },
];

export function AdminShell({ children }: { children: ReactNode }) {
  const pathname = useRouterState({ select: (s) => s.location.pathname });
  return (
    <div className="min-h-screen bg-muted/30">
      <div className="border-b border-amber-300 bg-amber-50 px-4 py-2 text-xs text-amber-900">
        <strong>Mock CMS</strong> · Phase 1C — in-memory only. No data is
        persisted, no API is called. Reloads reset all changes.
      </div>
      <div className="flex">
        <aside className="hidden w-56 shrink-0 border-r bg-background md:block">
          <div className="px-4 py-4">
            <div className="text-sm font-semibold tracking-tight">
              FARATECH CMS
            </div>
            <div className="text-[10px] uppercase tracking-wider text-muted-foreground">
              Admin (mock)
            </div>
          </div>
          <nav className="px-2 pb-4">
            {NAV.map((item) => {
              const Icon = item.icon;
              const active =
                !!item.to &&
                (pathname === item.to || pathname.startsWith(item.to + "/"));
              const base =
                "flex items-center gap-2 rounded-md px-2 py-1.5 text-sm transition-colors";
              if (item.disabled || !item.to) {
                return (
                  <div
                    key={item.label}
                    className={cn(base, "cursor-not-allowed text-muted-foreground/60")}
                  >
                    <Icon className="h-4 w-4" />
                    <span>{item.label}</span>
                    {item.badge && (
                      <span className="ml-auto rounded bg-muted px-1.5 py-0.5 text-[10px]">
                        {item.badge}
                      </span>
                    )}
                  </div>
                );
              }
              return (
                <Link
                  key={item.label}
                  to={item.to}
                  className={cn(
                    base,
                    active
                      ? "bg-foreground/5 font-medium text-foreground"
                      : "text-muted-foreground hover:bg-foreground/5 hover:text-foreground",
                  )}
                >
                  <Icon className="h-4 w-4" />
                  <span>{item.label}</span>
                </Link>
              );
            })}
          </nav>
        </aside>
        <main className="min-w-0 flex-1 p-4 md:p-8">{children}</main>
      </div>
    </div>
  );
}