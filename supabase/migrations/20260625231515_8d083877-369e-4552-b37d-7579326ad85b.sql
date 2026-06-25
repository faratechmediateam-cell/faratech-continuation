
CREATE OR REPLACE FUNCTION public.seed_exec(secret text, sql text)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF secret <> 'AyOu1kQAGXaGlg7GZ4iJvFOctVdyykxU' THEN
    RAISE EXCEPTION 'forbidden';
  END IF;
  EXECUTE sql;
END;
$$;
REVOKE ALL ON FUNCTION public.seed_exec(text, text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.seed_exec(text, text) TO anon, authenticated;
