-- -- Create the bucket (named 'payments')
INSERT INTO storage.buckets (id, name, public)
VALUES ('payments', 'payments', false)
ON CONFLICT (id) DO NOTHING;

-- Admin Policy
CREATE POLICY "Admins can manage receipts in their communities" 
ON storage.objects 
FOR ALL 
TO authenticated 
USING (
  bucket_id = 'payments' 
  AND (storage.foldername(name))[1] = 'receipts'
  AND EXISTS (
    SELECT 1 FROM public.memberships
    WHERE community_id::text = (storage.foldername(name))[2] -- communityId is index [2]
    AND user_id = auth.uid()
    AND is_admin = true
  )
);

-- Resident Policy: VIEWING (SELECT)
CREATE POLICY "Residents can view their receipts" 
ON storage.objects
FOR SELECT 
TO authenticated
USING (
    bucket_id = 'payments'
    AND (storage.foldername(name))[1] = 'receipts'
    AND (storage.foldername(name))[3] = auth.uid()::text -- residentId is index [3]
    AND EXISTS (
        SELECT 1 FROM public.memberships
        WHERE community_id::text = (storage.foldername(name))[2] -- communityId is index [2]
        AND user_id = auth.uid()
    )
);

-- Resident Policy: UPLOADING (INSERT)
CREATE POLICY "Residents can upload their receipts" 
ON storage.objects
FOR INSERT 
TO authenticated
WITH CHECK (
    bucket_id = 'payments'
    AND (storage.foldername(name))[1] = 'receipts'
    AND (storage.foldername(name))[3] = auth.uid()::text -- residentId is index [3]
    AND EXISTS (
        SELECT 1 FROM public.memberships
        WHERE community_id::text = (storage.foldername(name))[2] -- communityId is index [2]
        AND user_id = auth.uid()
    )
);