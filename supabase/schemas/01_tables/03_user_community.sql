CREATE TABLE user_community(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    community_id uuid NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
    status varchar(20) NOT NULL CHECK (status IN ('pending_approval', 'approved', 'rejected')),
    joined_at timestamp with time zone DEFAULT now(),
    UNIQUE (user_id, community_id)
);
