import { useQuery, useQueryClient } from "@tanstack/react-query";
import { Link, createFileRoute, useNavigate } from "@tanstack/react-router";
import { toast } from "sonner";

import { Button } from "@/components/ui/button";
import { ProductForm } from "@/components/admin/product-form";
import { productRepository, type ProductCategoryKey } from "@/lib/products/index";
import { CATEGORIES } from "@/lib/products";

export const Route = createFileRoute("/admin/products/$id")({
  component: EditProductPage,
});

function categoryOf(cmsId: string): ProductCategoryKey {
  for (const c of CATEGORIES) {
    if (c.products.some((p) => p.cmsId === cmsId)) return c.key;
  }
  return CATEGORIES[0]!.key;
}

function EditProductPage() {
  const { id } = Route.useParams();
  const navigate = useNavigate();
  const qc = useQueryClient();

  const q = useQuery({
    queryKey: ["admin-product", id],
    queryFn: () => productRepository.getById(id),
  });

  if (q.isLoading) return <div>Loading…</div>;
  if (!q.data)
    return (
      <div className="space-y-2">
        <p>Product not found.</p>
        <Button asChild variant="outline">
          <Link to="/admin/products">Back to list</Link>
        </Button>
      </div>
    );

  const product = q.data;
  const initialCategory = categoryOf(product.cmsId!);

  return (
    <div className="mx-auto max-w-3xl space-y-4">
      <div className="flex items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-semibold">{product.name}</h1>
          <p className="font-mono text-xs text-muted-foreground">
            {product.cmsId}
          </p>
        </div>
        <div className="flex gap-2">
          <Button asChild variant="outline">
            <Link
              to="/admin/products/$id/preview"
              params={{ id: product.cmsId! }}
            >
              Preview
            </Link>
          </Button>
          <Button asChild variant="ghost">
            <Link to="/admin/products">Back</Link>
          </Button>
        </div>
      </div>

      <ProductForm
        submitLabel="Save changes"
        initial={{ category: initialCategory, product }}
        onSubmit={async (v) => {
          await productRepository.update(product.cmsId!, {
            category: v.category,
            product: v.product,
          });
          toast.success("Saved (mock — not persisted)");
          qc.invalidateQueries({ queryKey: ["admin-product", id] });
          qc.invalidateQueries({ queryKey: ["admin-products"] });
          navigate({ to: "/admin/products" });
        }}
      />
    </div>
  );
}