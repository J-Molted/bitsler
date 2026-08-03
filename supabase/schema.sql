-- Supabase SQL Editor 에서 1회 실행
-- 두 게임의 배수 사다리가 다르므로 테이블을 분리합니다.

create table if not exists shuffle_rounds (
  id         bigserial   primary key,
  seed       text        not null,
  n          int         not null,
  idx        int         not null,   -- 0..19  (Shuffle: 20칸)
  mult       numeric     not null,
  created_at timestamptz not null default now()
);
create index if not exists shuffle_rounds_seed_n on shuffle_rounds(seed, n);
alter table shuffle_rounds enable row level security;
drop policy if exists "anon all" on shuffle_rounds;
create policy "anon all" on shuffle_rounds
  for all to anon using (true) with check (true);

create table if not exists bitsler_rounds (
  id         bigserial   primary key,
  seed       text        not null,
  n          int         not null,
  idx        int         not null,   -- 0..24  (Bitsler: 25칸)
  mult       numeric     not null,
  created_at timestamptz not null default now()
);
create index if not exists bitsler_rounds_seed_n on bitsler_rounds(seed, n);
alter table bitsler_rounds enable row level security;
drop policy if exists "anon all" on bitsler_rounds;
create policy "anon all" on bitsler_rounds
  for all to anon using (true) with check (true);
