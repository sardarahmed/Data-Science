create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique check (char_length(username) between 3 and 20),
  display_name text not null,
  avatar_url text,
  bio text not null default '',
  privacy jsonb not null default '{"public_profile": true}'::jsonb,
  total_matches integer not null default 0,
  total_wins integer not null default 0,
  total_points integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.groups (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text not null default '',
  avatar_url text,
  category text not null default 'Other',
  join_code text not null unique,
  is_public boolean not null default true,
  require_approval boolean not null default false,
  owner_id uuid not null references public.profiles(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.group_members (
  group_id uuid not null references public.groups(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  role text not null default 'member' check (role in ('owner','moderator','member')),
  status text not null default 'active' check (status in ('active','pending')),
  joined_at timestamptz not null default now(),
  primary key (group_id, user_id)
);

create table if not exists public.group_invites (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups(id) on delete cascade,
  inviter_id uuid not null references public.profiles(id),
  invitee_id uuid references public.profiles(id),
  code text not null unique,
  expires_at timestamptz,
  accepted_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.rooms (
  id uuid primary key default gen_random_uuid(),
  group_id uuid references public.groups(id),
  host_id uuid not null references public.profiles(id),
  code text not null unique,
  max_players integer not null check (max_players between 3 and 10),
  rounds integer not null check (rounds in (3,5,7)),
  status text not null default 'waiting',
  is_private boolean not null default false,
  created_at timestamptz not null default now(),
  expires_at timestamptz
);

create table if not exists public.game_sessions (
  id uuid primary key default gen_random_uuid(),
  room_id uuid not null references public.rooms(id) on delete cascade,
  current_round integer not null default 1,
  status text not null default 'active',
  winner_player_id uuid references public.profiles(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  completed_at timestamptz
);

create table if not exists public.scenarios (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  story text not null,
  category text not null,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.decisions (
  id uuid primary key default gen_random_uuid(),
  scenario_id uuid not null references public.scenarios(id) on delete cascade,
  text text not null,
  position integer not null,
  unique (scenario_id, position)
);

create table if not exists public.consequences (
  id uuid primary key default gen_random_uuid(),
  decision_id uuid not null references public.decisions(id) on delete cascade,
  text text not null
);

create table if not exists public.achievements (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  description text not null,
  icon text
);

create table if not exists public.user_achievements (
  user_id uuid not null references public.profiles(id) on delete cascade,
  achievement_id uuid not null references public.achievements(id) on delete cascade,
  unlocked_at timestamptz not null default now(),
  primary key (user_id, achievement_id)
);

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  type text not null,
  title text not null,
  body text not null,
  read_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.daily_challenges (
  id uuid primary key default gen_random_uuid(),
  challenge_date date not null unique,
  scenario_id uuid references public.scenarios(id),
  title text not null,
  description text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.daily_submissions (
  challenge_id uuid not null references public.daily_challenges(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  decision_id uuid references public.decisions(id),
  submitted_at timestamptz not null default now(),
  primary key (challenge_id, user_id)
);

create index if not exists idx_group_members_user on public.group_members(user_id);
create index if not exists idx_group_members_group on public.group_members(group_id);
create index if not exists idx_rooms_group on public.rooms(group_id);
create index if not exists idx_notifications_user on public.notifications(user_id, created_at desc);
create index if not exists idx_daily_submissions_user on public.daily_submissions(user_id);

alter table public.profiles enable row level security;
alter table public.groups enable row level security;
alter table public.group_members enable row level security;
alter table public.group_invites enable row level security;
alter table public.rooms enable row level security;
alter table public.game_sessions enable row level security;
alter table public.scenarios enable row level security;
alter table public.decisions enable row level security;
alter table public.consequences enable row level security;
alter table public.achievements enable row level security;
alter table public.user_achievements enable row level security;
alter table public.notifications enable row level security;
alter table public.daily_challenges enable row level security;
alter table public.daily_submissions enable row level security;

create policy "Profiles are public to authenticated users"
on public.profiles for select to authenticated using (true);

create policy "Users manage own profile"
on public.profiles for all to authenticated
using (id = auth.uid()) with check (id = auth.uid());

create policy "Public groups are discoverable"
on public.groups for select to authenticated
using (is_public = true or exists (
  select 1 from public.group_members
  where group_id = groups.id and user_id = auth.uid() and status = 'active'
));

create policy "Group owners manage groups"
on public.groups for all to authenticated
using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy "Members read active memberships"
on public.group_members for select to authenticated
using (group_id in (
  select group_id from public.group_members
  where user_id = auth.uid() and status = 'active'
));

create policy "Own notifications"
on public.notifications for all to authenticated
using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "Authenticated read achievements"
on public.achievements for select to authenticated using (true);

create policy "Users read own achievements"
on public.user_achievements for select to authenticated
using (user_id = auth.uid());

create table if not exists public.votes (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references public.game_sessions(id) on delete cascade,
  round integer not null,
  player_id uuid not null references public.profiles(id) on delete cascade,
  decision_id uuid not null references public.decisions(id),
  created_at timestamptz not null default now(),
  revealed_at timestamptz,
  unique (session_id, round, player_id)
);

create table if not exists public.activity_feed (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups(id) on delete cascade,
  actor_id uuid references public.profiles(id),
  type text not null,
  title text not null,
  body text not null default '',
  created_at timestamptz not null default now()
);

create table if not exists public.async_challenges (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups(id) on delete cascade,
  creator_id uuid not null references public.profiles(id),
  scenario_id uuid not null references public.scenarios(id),
  deadline timestamptz,
  status text not null default 'active',
  created_at timestamptz not null default now()
);

alter table public.votes enable row level security;
alter table public.activity_feed enable row level security;
alter table public.async_challenges enable row level security;

create policy "Members read authorized group activity"
on public.activity_feed for select to authenticated
using (group_id in (
  select group_id from public.group_members
  where user_id = auth.uid() and status = 'active'
));

create policy "Members read authorized async challenges"
on public.async_challenges for select to authenticated
using (group_id in (
  select group_id from public.group_members
  where user_id = auth.uid() and status = 'active'
));

create policy "Players submit and read own hidden votes"
on public.votes for all to authenticated
using (player_id = auth.uid())
with check (player_id = auth.uid());

create policy "Authenticated read active scenarios"
on public.scenarios for select to authenticated using (active = true);

create policy "Authenticated read scenario decisions"
on public.decisions for select to authenticated using (true);

create policy "Authenticated read consequences"
on public.consequences for select to authenticated using (true);

create policy "Users read room membership"
on public.rooms for select to authenticated
using (
  host_id = auth.uid()
  or is_private = false
  or group_id in (
    select group_id from public.group_members
    where user_id = auth.uid() and status = 'active'
  )
);

create policy "Hosts create rooms"
on public.rooms for insert to authenticated
with check (host_id = auth.uid());

create policy "Group members read sessions"
on public.game_sessions for select to authenticated
using (room_id in (
  select id from public.rooms
  where host_id = auth.uid()
));

create policy "Users read own invitations"
on public.group_invites for select to authenticated
using (inviter_id = auth.uid() or invitee_id = auth.uid());

create policy "Authorized users create invitations"
on public.group_invites for insert to authenticated
with check (
  inviter_id = auth.uid()
  and exists (
    select 1 from public.group_members
    where group_id = group_invites.group_id
      and user_id = auth.uid()
      and role in ('owner','moderator')
      and status = 'active'
  )
);

create policy "Daily challenges are discoverable"
on public.daily_challenges for select to authenticated using (true);

create policy "Users manage own daily submissions"
on public.daily_submissions for all to authenticated
using (user_id = auth.uid()) with check (user_id = auth.uid());
