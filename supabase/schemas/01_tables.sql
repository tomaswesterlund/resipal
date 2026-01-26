CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- uud UUID NOT NULL, -- Reference later to auth.users(id)
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    emergency_phone_number TEXT NOT NULL,
    email TEXT NOT NULL
);

CREATE TABLE properties (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    description TEXT
);

CREATE TABLE movements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    amount_in_cents INT NOT NULL,
    type TEXT NOT NULL,
    ref_source TEXT NOT NULL,
    ref_id TEXT NOT NULL
);


CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    amount_in_cents INT NOT NULL,
    status TEXT NOT NULL,
    date TIMESTAMPTZ NOT NULL,
    reference TEXT,
    note TEXT
);

CREATE TABLE visitors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL
);

CREATE TABLE invitations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    property_id UUID NOT NULL REFERENCES properties(id),
    visitor_id UUID NOT NULL REFERENCES visitors(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    qr_code_token UUID NOT NULL,
    from_date TIMESTAMPTZ NOT NULL,
    to_date TIMESTAMPTZ NOT NULL,
    max_entries INT NOT NULL
);

CREATE TABLE access_logs(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invitation_id UUID NOT NULL REFERENCES invitations(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    direction TEXT NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL
);