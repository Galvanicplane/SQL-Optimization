-- BÖLÜM 1: TEMİZ VİTRİN
-- İzleme öncesi eski sorguları temizleyelim ki sonuçlarda sadece bizim sorgu görünsün.
SELECT pg_stat_statements_reset();

-- BÖLÜM 2: SİSTEMİ YORAN "KÖTÜ" SORGU (FULL TABLE/SEQ SCAN)
-- Index olmadığı için çok uzun sürecek bir filtreleme işlemi
SELECT * 
FROM airports 
WHERE type = 'small_airport' 
  AND iso_country = 'US' 
ORDER BY name DESC;

-- BÖLÜM 3: "PG_STAT_STATEMENTS" İLE DARBOĞAZ TESPİTİ
-- Ortalama çalışma süresi (mean_exec_time) en yüksek olan komutları listeleyerek yavaş sorguyu saptama
SELECT 
    query, 
    calls, -- Kaç kez çalıştırıldı
    round(total_exec_time::numeric, 2) AS total_time_ms, -- Toplam süresi
    round(mean_exec_time::numeric, 2) AS mean_time_ms, -- Ortalama cevap süresi
    rows -- Ekrana dönen satır
FROM 
    pg_stat_statements
WHERE query NOT ILIKE '%pg_stat_statements%' -- Kendi izleme sorgumuzu eledik
ORDER BY 
    total_exec_time DESC 
LIMIT 5;
