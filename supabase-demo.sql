-- Olé · démo commande : table partagée en temps réel
-- À coller dans Supabase > SQL Editor > New query, puis "Run".
-- Démo uniquement : n'importe qui ayant le lien peut lire et écrire ces commandes de test.

create table if not exists public.ole_demo (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.ole_demo enable row level security;

drop policy if exists "demo lecture" on public.ole_demo;
drop policy if exists "demo ajout" on public.ole_demo;
drop policy if exists "demo modif" on public.ole_demo;
create policy "demo lecture" on public.ole_demo for select to anon using (true);
create policy "demo ajout" on public.ole_demo for insert to anon with check (true);
create policy "demo modif" on public.ole_demo for update to anon using (true) with check (true);

alter publication supabase_realtime add table public.ole_demo;
