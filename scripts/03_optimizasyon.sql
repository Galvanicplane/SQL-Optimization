-- BÖLÜM 1: OPTİMİZASYON ÖNCESİ MALİYET HESABI
-- Seq Scan (Tüm tabloyu okuma) yapıldığını ve yüksek 'cost' & 'execution time' değerlerini göster.
EXPLAIN ANALYZE 
SELECT * 
FROM users_log 
WHERE user_id = 45214 
  AND event_type = 'login' 
ORDER BY event_date DESC;


-- BÖLÜM 2: OPTİMİZASYON - İNDEKS OLUŞTURMA
-- user_id ve event_type birleşimi üzerinden filtreleme yapıldığı için Composite (Bileşik) Index oluşturuyoruz:
CREATE INDEX idx_users_log_user_event ON users_log(user_id, event_type);


-- BÖLÜM 3: OPTİMİZASYON SONRASI YENİDEN KONTROL
-- Index Scan (Sadece endeksleri okuma) yapıldığını ve Execution Time'ın nasıl milisaniyelere düştüğünü göster.
EXPLAIN ANALYZE 
SELECT * 
FROM users_log 
WHERE user_id = 45214 
  AND event_type = 'login' 
ORDER BY event_date DESC;
