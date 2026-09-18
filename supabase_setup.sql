-- YT Queue: Supabase setup
-- Run this once in Supabase Dashboard > SQL Editor.

create table if not exists public.yt_queue_state (
  user_id uuid primary key references auth.users(id) on delete cascade default auth.uid(),
  state jsonb not null default '{"items":[],"i":-1}'::jsonb,
  settings jsonb not null default '{"rate":1,"auto":true}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.yt_queue_state enable row level security;

revoke all on table public.yt_queue_state from anon, authenticated;
grant select, insert, update on table public.yt_queue_state to authenticated;

drop policy if exists "ytq_select_own" on public.yt_queue_state;
drop policy if exists "ytq_insert_own" on public.yt_queue_state;
drop policy if exists "ytq_update_own" on public.yt_queue_state;

create policy "ytq_select_own"
on public.yt_queue_state for select
to authenticated
using ((select auth.uid()) = user_id);

create policy "ytq_insert_own"
on public.yt_queue_state for insert
to authenticated
with check ((select auth.uid()) = user_id);

create policy "ytq_update_own"
on public.yt_queue_state for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);
