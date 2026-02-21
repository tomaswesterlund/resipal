CREATE POLICY "Admins can insert contracts" 
ON contracts 
FOR INSERT 
WITH CHECK (fn_check_is_admin(auth.uid(), community_id));