import { createFileRoute, notFound } from "@tanstack/react-router";
import { ProductPage } from "@/components/faratech/product-page";
import type { Lang } from "@/lib/i18n";
import { buildLocaleMeta } from "@/lib/seo";
import {
  getProductBySlug,
  listProducts,
} from "@/lib/modules/products/product.functions";
import {
  getCategoryCopy,
  listCategories,
} from "@/lib/modules/categories/category.functions";
import { detailToProduct, dtoToCategory } from "@/lib/products-db-adapter";
import { slugToEnum } from "@/lib/category-slug";

export const Route = createFileRoute("/$lang/products/$category/$product")({
  loader: async ({ params }) => {
    const enumKey = slugToEnum(params.category);
    if (!enumKey) throw notFound();

    // notFound() inside the server fn is already mapped; surface as 404.
    const detail = await getProductBySlug({ data: { slug: params.product } });

    // Defensive: ensure the product really belongs to the requested category.
    if (detail.categoryKey !== enumKey) throw notFound();

    const [allCategories, productsResult, copy] = await Promise.all([
      listCategories(),
      listProducts({ data: { categoryKey: enumKey, limit: 100, offset: 0 } }),
      getCategoryCopy({ data: { slug: params.category } }),
    ]);
    const catDto = allCategories.find((c) => c.key === enumKey);
    if (!catDto) throw notFound();

    return {
      category: dtoToCategory(catDto, productsResult.items, copy),
      product: detailToProduct(detail),
    };
  },
  head: ({ loaderData, params }) => {
    const lang = (params?.lang as Lang) ?? "fa";
    const cat = params?.category ?? "";
    const prod = params?.product ?? "";
    const locale = buildLocaleMeta(lang, (l) => `/${l}/products/${cat}/${prod}`);
    const name = loaderData?.product.name ?? "Product";
    const description = `${name} — engineered by FARATECH.`;
    return {
      meta: [
        { title: `${name} — FARATECH` },
        { name: "description", content: description },
        { property: "og:title", content: `${name} — FARATECH` },
        { property: "og:description", content: description },
        { property: "og:type", content: "product" },
        ...locale.meta,
      ],
      links: locale.links,
    };
  },
  errorComponent: ({ error }) => (
    <div className="max-w-2xl mx-auto p-8 text-sm text-red-600">
      Failed to load product: {error.message}
    </div>
  ),
  notFoundComponent: () => <div className="p-8">Product not found.</div>,
  component: ProductView,
});

function ProductView() {
  const { lang } = Route.useParams();
  const { category, product } = Route.useLoaderData();
  return <ProductPage lang={lang as Lang} category={category} product={product} />;
}
