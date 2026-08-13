-- Atelier — schéma des annonces synchronisées
-- À coller dans Supabase → SQL Editor → New query → Run.
-- Sans risque à relancer : tout est en "if not exists" / "drop policy if exists".

-- ───────────────────────────────────────────────────────────────
-- 1. La table des annonces
-- ───────────────────────────────────────────────────────────────
create table if not exists public.annonces (
  id          uuid primary key,
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  deleted_at  timestamptz,                       -- suppression marquée, pour que l'effacement se propage
  statut      text not null default 'brouillon',
  titre       text not null default '',
  description text not null default '',
  mesures     text not null default '',
  notes       text not null default '',
  prix        numeric,
  achat       numeric,
  marque      text not null default '',
  taille      text not null default '',
  etat        text not null default '',
  vignette    text,                              -- miniature en data URL, pour afficher la liste sans rien télécharger
  photos      jsonb not null default '[]'::jsonb -- [{name, path}] — les fichiers vivent dans le bucket
);

create index if not exists annonces_user_maj on public.annonces (user_id, updated_at desc);

-- ───────────────────────────────────────────────────────────────
-- 2. Chaque compte ne voit que ses propres annonces
-- ───────────────────────────────────────────────────────────────
alter table public.annonces enable row level security;

drop policy if exists "lire ses annonces"      on public.annonces;
drop policy if exists "créer ses annonces"     on public.annonces;
drop policy if exists "modifier ses annonces"  on public.annonces;
drop policy if exists "supprimer ses annonces" on public.annonces;

create policy "lire ses annonces" on public.annonces
  for select using (auth.uid() = user_id);
create policy "créer ses annonces" on public.annonces
  for insert with check (auth.uid() = user_id);
create policy "modifier ses annonces" on public.annonces
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "supprimer ses annonces" on public.annonces
  for delete using (auth.uid() = user_id);

-- ───────────────────────────────────────────────────────────────
-- 3. Le stockage des photos, privé, rangé par compte
-- ───────────────────────────────────────────────────────────────
insert into storage.buckets (id, name, public)
  values ('photos', 'photos', false)
  on conflict (id) do nothing;

drop policy if exists "lire ses photos"      on storage.objects;
drop policy if exists "déposer ses photos"   on storage.objects;
drop policy if exists "remplacer ses photos" on storage.objects;
drop policy if exists "effacer ses photos"   on storage.objects;

-- Le premier dossier du chemin est l'identifiant du compte : photos/<user_id>/<annonce>/<fichier>
create policy "lire ses photos" on storage.objects
  for select using (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "déposer ses photos" on storage.objects
  for insert with check (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "remplacer ses photos" on storage.objects
  for update using (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "effacer ses photos" on storage.objects
  for delete using (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);
