-- Nuestra casita: esquema inicial privado
-- Ejecuta en Supabase > SQL Editor > New query.
-- Nunca uses service_role/secret keys en el navegador.

create extension if not exists pgcrypto;
create table if not exists public.messages (
 id uuid primary key default gen_random_uuid(),
 title text not null default '' check (char_length(title)<=100),
 body text not null check (char_length(body) between 1 and 5000),
 created_at timestamptz not null default now()
);
create table if not exists public.replies (
 id uuid primary key default gen_random_uuid(),
 message_id uuid not null references public.messages(id) on delete cascade,
 body text not null check (char_length(body) between 1 and 3000),
 created_at timestamptz not null default now()
);
create table if not exists public.diary_entries (
 id uuid primary key default gen_random_uuid(),
 title text not null check (char_length(title) between 1 and 120),
 body text not null check (char_length(body) between 1 and 5000),
 created_at timestamptz not null default now()
);
alter table public.messages enable row level security;
alter table public.replies enable row level security;
alter table public.diary_entries enable row level security;
drop policy if exists "Authenticated users can read messages" on public.messages;
create policy "Authenticated users can read messages" on public.messages for select to authenticated using (true);
drop policy if exists "Authenticated users can send messages" on public.messages;
create policy "Authenticated users can send messages" on public.messages for insert to authenticated with check (true);
drop policy if exists "Authenticated users can read replies" on public.replies;
create policy "Authenticated users can read replies" on public.replies for select to authenticated using (true);
drop policy if exists "Authenticated users can send replies" on public.replies;
create policy "Authenticated users can send replies" on public.replies for insert to authenticated with check (true);
drop policy if exists "Authenticated users can read diary" on public.diary_entries;
create policy "Authenticated users can read diary" on public.diary_entries for select to authenticated using (true);
drop policy if exists "Authenticated users can add diary entries" on public.diary_entries;
create policy "Authenticated users can add diary entries" on public.diary_entries for insert to authenticated with check (true);
-- Crea una única cuenta compartida en Authentication > Users > Add user.
-- No habilites el registro público. Quien tenga esas credenciales podrá leer/escribir todo.
