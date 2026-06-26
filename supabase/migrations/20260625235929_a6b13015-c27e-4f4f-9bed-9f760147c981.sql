-- Phase 7: media storage policies
-- The product-media bucket is private (workspace blocks public buckets).
-- Reads are proxied through a public server route using the service role.
-- Only service_role may write/update/delete directly.

CREATE POLICY "service_role manages product-media"
ON storage.objects
FOR ALL
TO service_role
USING (bucket_id = 'product-media')
WITH CHECK (bucket_id = 'product-media');
