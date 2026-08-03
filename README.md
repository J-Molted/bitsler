# Chicken Game Tracker

크래시/치킨류 게임의 결과를 기록하고 **RNG 가 공표된 모델을 따르는지 순차검정**하는 도구.
예측기가 아니라 이상 탐지기입니다.

| 사이트 | 게임 | 구조 | 테이블 |
|---|---|---|---|
| `/` | Bitsler Risky Chicken | 25칸 균등 4% · RTP 96% | `bitsler_rounds` |
| `/shuffle/` | Shuffle Chicken | 20칸 균등 5% · RTP 98% | `shuffle_rounds` |

## 모델

두 게임 모두 `P(도달 m) = RTP / m` 이 **정확히 등간격**이라, 결과는 각 칸이 균등 확률인
단일 추첨입니다. 따라서 어느 지점에서 익절해도 기대 회수율은 동일하고,
과거 결과로 다음 판을 예측할 수 없습니다 (마르코프 독립성·런검정·자기상관 전부 통과).

**단 하나의 예외**: Bitsler 는 배당을 내림 표기해서 목표마다 실제 RTP 가 다릅니다.
`1.04 / 1.84` 는 −0.32%p 손해, `1 · 1.2 · 1.5 · 1.6 · 2 · 2.4 · 3 · 4 · 4.8 · 6 · 8 · 12 · 24` 는 손실 0.
확률이 아니라 산수라 항상 성립합니다.

## 검정 패널

- **READY 지수** — 고배수 가뭄의 통계적 극단성. "곧 나온다"가 아니라 "seed 가 수상하다"는 신호
- **CUSUM / SPRT / χ²** — 균등 모델에서 벗어나는지 순차검정
- **칸별 이상 감지** — 칸마다 이항 정확검정 + Benjamini-Hochberg FDR 보정
- **목표별 Wilson 95% CI**, **뱅크롤 / 드로다운 / 파산확률**

## 배포

1. Supabase SQL Editor 에서 `supabase/schema.sql` 실행
2. 각 `index.html` 상단의 `SUPABASE_URL` / `SUPABASE_KEY` 확인
3. Netlify 에 이 저장소를 연결 — 빌드 명령 없음, publish 디렉터리 `.`

`SUPABASE_KEY` 는 publishable key 라 공개돼도 됩니다.
service_role / secret key 는 **절대 커밋하지 마세요.**
