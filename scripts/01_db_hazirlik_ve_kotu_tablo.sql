-- BÖLÜM 1: EKLENTİ YÜKLEME 
-- Container ayağa kalktığında pg_stat_statements yüklü olsa da veritabanında aktif etmeliyiz.
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- BÖLÜM 2: BİLİNÇLİ OLARAK KÖTÜ TASARLANMIŞ TABLO
-- İçerisinde kasten PRIMARY KEY veya INDEX bulunmuyor.
DROP TABLE IF EXISTS users_log;

CREATE TABLE users_log (
    id SERIAL, -- Index veya Primary Key koymadık!
    user_id INT,
    event_type VARCHAR(50),
    event_date TIMESTAMP,
    details TEXT
);

-- BÖLÜM 3: MİLYONLARCA SAHTE VERİ (DUMMY DATA) ÜRETİMİ
-- generate_series ile 2 milyon rastgele kayıt oluşturuyoruz. (Bilgisayarızın hızına göre birkaç saniye sürebilir)
INSERT INTO users_log (user_id, event_type, event_date, details)
SELECT 
    (random() * 100000)::INT,
    CASE WHEN random() < 0.2 THEN 'login' ELSE 'click' END,
    NOW() - (random() * 365 * interval '1 day'),
    'Detailed log info hash: ' || md5(random()::text)
FROM generate_series(1, 2000000);

-- Eklendiğini teyit edelim
SELECT COUNT(*) FROM users_log;
