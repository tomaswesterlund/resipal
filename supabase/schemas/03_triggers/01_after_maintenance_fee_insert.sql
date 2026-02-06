CREATE OR REPLACE FUNCTION fn_after_maintenance_fee_insert()
RETURNS TRIGGER AS $$
DECLARE
    v_user_id UUID;
BEGIN
    -- -- 1. Get the user_id associated with the property in the contract
    -- SELECT p.user_id INTO v_user_id
    -- FROM public.properties p
    -- JOIN public.maintenance_contracts mc ON mc.property_id = p.id
    -- WHERE mc.id = NEW.contract_id;

    -- -- 2. Insert into movements
    -- INSERT INTO public.movements (
    --     user_id,
    --     amount_in_cents,
    --     type,
    --     ref_id,
    --     created_at
    -- )
    -- VALUES (
    --     v_user_id,
    --     NEW.amount_in_cents,
    --     'maintenance_fee',
    --     NEW.id::TEXT,
    --     NEW.created_at
    -- );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_maintenance_fee_insert
AFTER INSERT ON public.maintenance_fees
FOR EACH ROW
EXECUTE FUNCTION fn_after_maintenance_fee_insert();