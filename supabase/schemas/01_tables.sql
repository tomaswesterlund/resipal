CREATE TABLE profile (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL, -- Reference later to auth.users(id)
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    emergency_phone_number TEXT NOT NULL,
    email TEXT NOT NULL
);

CREATE TABLE movements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL, -- Reference later to auth.users(id)
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    amount_in_cents INT NOT NULL,
    type TEXT NOT NULL,
    ref_source TEXT NOT NULL,
    ref_id TEXT NOT NULL
);


CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL, -- Reference later to auth.users(id)
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    amount_in_cents INT NOT NULL,
    date TIMESTAMPTZ NOT NULL,
    reference TEXT,
    note TEXT
);