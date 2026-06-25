import { createFileRoute, useNavigate } from "@tanstack/react-router";
import { toast } from "sonner";

import { ProductForm } from "@/components/admin/product-form";
import { productRepository } from "@/lib/products/index";
import { CATEGORIES } from "@/lib/products";

export const Route = createFileRoute("/admin/products/new")({
  component: NewProductPage,
});

function NewProductPage() {
  const navigate = useNavigate();
  return (
    <div className="mx-auto max-w-3xl space-y-4">
      <h1 className="text-xl font-semibold">New product</h1>
      <ProductForm
        submitLabel="Create draft"
        initial={{
          category: CATEGORIES[0]!.key,
          product: { slug: "", name: "", status: "draft" },
        }}
        onSubmit={async (v) => {
          const created = await productRepository.create({
            category: v.category,
            product: v.product,
          });
          toast.success("Product created (mock — not persisted)");
          navigate({
            to: "/admin/products/$id",
            params: { id: created.cmsId! },
          });
        }}
      />
    </div>
  );
}