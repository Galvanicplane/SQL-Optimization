-- BÖLÜM 1: OPTİMİZASYON ÖNCESİ MALİYET HESABI
-- Seq Scan (Tüm tabloyu okuma) yapıldığını ve yüksek 'cost' & 'execution time' değerlerini göster.
EXPLAIN ANALYZE 
SELECT * 
FROM airports 
WHERE type = 'small_airport' 
  AND iso_country = 'US' 
ORDER BY name DESC;


-- BÖLÜM 2: OPTİMİZASYON - İNDEKS OLUŞTURMA
-- type ve iso_country birleşimi üzerinden filtreleme yapıldığı için Composite (Bileşik) Index oluşturuyoruz:
CREATE INDEX idx_airports_type_country ON airports(type, iso_country);


-- BÖLÜM 3: OPTİMİZASYON SONRASI YENİDEN KONTROL
-- Index Scan (Sadece endeksleri okuma) yapıldığını ve Execution Time'ın nasıl milisaniyelere düştüğünü göster.
EXPLAIN ANALYZE 
SELECT * 
FROM airports 
WHERE type = 'small_airport' 
  AND iso_country = 'US' 
ORDER BY name DESC;
